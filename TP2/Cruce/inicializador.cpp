#include "../Sem-sv/sv_sem.h"
#include "../Sem-sv/sv_shm.h"

typedef struct{
    int simios_en_soga=0;
    } shared_status;

int main(){
	sv_sem mutex ("Mutex",1);
	sv_sem simios_cruzando("Simios Cruzando",1);
	cout<<"Sémaforos inicializados"<<endl<<mutex<<endl<<simios_cruzando<<endl;
	shared_status * status;
	sv_shm soga("Soga");
	status= reinterpret_cast<shared_status *> (soga.map(sizeof (shared_status)));
	status->simios_en_soga=0;
	cout<<"Area compartida inicializada."<<endl;
}
