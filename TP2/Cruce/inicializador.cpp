#include "../Sem-sv/sv_sem.h"
#include "../Sem-sv/sv_shm.h"

typedef struct{
    int simios_cruzando_DI=0;
    int simios_cruzando_ID=0;
    int simios_esperando_DI=0;
    int simios_esperando_ID=0;
    } shared_status;

int main(){
	sv_sem mutex ("Mutex",1);
	sv_sem DI("Simio_cruzando_derecha_a_izquierda",1);
	sv_sem ID("Simio_cruzando_izquierda_a_derecha",1);
	cout<<"Sémaforos inicializados"<<endl<<mutex<<endl<<DI<<endl<<ID<<endl;
	shared_status * status;
	sv_shm soga("Soga");
	status= reinterpret_cast<shared_status *> (soga.map(sizeof (shared_status)));
	status->simios_cruzando_DI=0;
	status->simios_cruzando_ID=0;
	status->simios_esperando_DI=0;
	status->simios_esperando_ID=0;
	cout<<"Area compartida inicializada."<<endl;
}
