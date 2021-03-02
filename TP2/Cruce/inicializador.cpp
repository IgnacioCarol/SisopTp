#include "../Sem-sv/sv_sem.h"
#include "../Sem-sv/sv_shm.h"

typedef struct{
    int simios_cruzando_DI=0;
    int simios_cruzando_ID=0;
    int simios_esperando_DI=0;
    int simios_esperando_ID=0;
    } shared_status;

int main(){
    cout<<"Grupo 2"<<endl<<endl;
    cout<<"99599    MININO, ALAN NAHUEL         nminino@fi.uba.ar"<<endl;
    cout<<"99846    TORRESETTI, LISANDRO        ltorresetti@fi.uba.ar"<<endl;
    cout<<"100073   CAROL LUGONES, LUIS IGNACIO icarol@fi.uba.ar"<<endl<<endl;

	sv_sem mutex ("Mutex",1);
	sv_sem DI("Simio_cruzando_derecha_a_izquierda",0);
	sv_sem ID("Simio_cruzando_izquierda_a_derecha",0);
	cout<<"Semáforos inicializados:"<<endl<<mutex<<endl<<DI<<endl<<ID<<endl;
	shared_status * status;
	sv_shm soga("Soga");
	status= reinterpret_cast<shared_status *> (soga.map(sizeof (shared_status)));
	status->simios_cruzando_DI=0;
	status->simios_cruzando_ID=0;
	status->simios_esperando_DI=0;
	status->simios_esperando_ID=0;
	cout<<"Área compartida inicializada."<<endl;
}
