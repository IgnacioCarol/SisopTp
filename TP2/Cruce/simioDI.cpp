#include <iostream>
#include "../Sem-sv/sv_sem.h"
#include "../Sem-sv/sv_shm.h"
#include "./utils/utils.cpp"
using namespace std;

typedef struct{
    int simios_cruzando_DI=0;
    int simios_cruzando_ID=0;
    int simios_esperando_DI=0;
    int simios_esperando_ID=0;
    } shared_status;

int main(int argc, char * argv[]){
    printNames();
	if (argc<2) {
	    cerr<<"Usar "<<argv[0]<<" indicando el <id del simioDI> como parámetro."<<endl;
	    exit(2);
	}
	
	string nombreSimio="SimioDI_"+string(argv[1]);
	string rta;
	sv_sem mutex("Mutex");
	sv_sem DI("Simio_cruzando_derecha_a_izquierda");
	sv_sem ID("Simio_cruzando_izquierda_a_derecha");
	shared_status * status;
	sv_shm soga("Soga");
	status= reinterpret_cast<shared_status *> (soga.map(sizeof (shared_status)));
	
	cout<<nombreSimio<<" (pid: "<<getpid()<<") a punto de cruzar..."<<endl;
	cin>>rta;
	cout<<nombreSimio<<" (pid: "<<getpid()<<") prueba ingreso a la soga... \n";

	mutex.wait();
	if (status->simios_cruzando_ID > 0){
	    /*Caso en el que hay simios cruzando de izquierda a derecha*/
	    status->simios_esperando_DI++;
	    mutex.post();
	    DI.wait();
	} else {
	    /*Caso en el que se puede cruzar*/
	    status->simios_cruzando_DI++;
	    mutex.post();
	}
	
	/*El simio entra a la sección crítica*/
	cout<<nombreSimio<<" (pid: "<<getpid()<<") cruzando..."<<endl;
	cin>>rta;
	
	mutex.wait();
	status->simios_cruzando_DI--;
	
	if (status->simios_esperando_DI > 0){
	    /*Caso en el que hay más simios cruzando de derecha a izquierda*/
	    status->simios_cruzando_DI++;
	    status->simios_esperando_DI--;
	    ID.post();
	} else if (status->simios_esperando_ID > 0 and status->simios_cruzando_DI == 0) {
	    /*Caso en el que terminaron de cruzar los simios*/
	    int simios_que_empiezan_a_cruzar=status->simios_esperando_ID;
	    status->simios_esperando_ID=0;
	    status->simios_cruzando_ID=status->simios_cruzando_ID+simios_que_empiezan_a_cruzar;
	    for(int i=0; i<simios_que_empiezan_a_cruzar; i++) {
	        ID.post();
	    }
	}
	
	if (status->simios_esperando_DI == 0) cout<<nombreSimio<<" "<<" es el último simio cruzando de derecha a izquierda."<<endl;
    mutex.post();
    cout<<nombreSimio<<" "<<" terminó de cruzar."<<endl;
}
