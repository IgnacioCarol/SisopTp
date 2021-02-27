#include <iostream>
#include "../Sem-sv/sv_sem.h"
#include "../Sem-sv/sv_shm.h"
using namespace std;

typedef struct{
    int simios_en_soga=0;
    } shared_status;

int main(int argc, char * argv[]){
	if (argc<2) {
	    cerr<<"Usar"<<argv[0]<<" indicando el <id del simioID> como parámetro."<<endl;
	    exit(2);
	}
	string nombreSimio="SimioDI_"+string(argv[1]);
	string rta;
	sv_sem mutex("Mutex");
	sv_sem simios_cruzando("Simios Cruzando");
	shared_status * status;
	sv_shm soga("Soga");
	status= reinterpret_cast<shared_status *> (soga.map(sizeof (shared_status)));
	
	cout<<nombreSimio<<" "<<getpid()<<" a punto de cruzar..."<<endl;
	cin>>rta;
	cout<<nombreSimio<<" "<<getpid()<<" prueba ingreso \n";
	mutex.wait();
	if (++status->simios_en_soga == 1)simios_cruzando.wait();
	mutex.post();
	cout<<nombreSimio<<" "<<getpid()<<" cruzando..."<<endl;
	cin>>rta;
	mutex.wait();
	if (--status->simios_en_soga == 0){
	    cout<<nombreSimio<<" "<<" es el último simio cruzando de derecha a izquierda."<<endl;
	    simios_cruzando.post();
	}
    mutex.post();
    cout<<nombreSimio<<" "<<" terminó de cruzar."<<endl;
}
