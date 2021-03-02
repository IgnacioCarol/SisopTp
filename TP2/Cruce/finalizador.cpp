#include <iostream>
#include "../Sem-sv/sv_sem.h"
#include "../Sem-sv/sv_shm.h"
using namespace std;

int main(int argc, char * argv[]){
    cout<<"Grupo 2"<<endl<<endl;
    cout<<"99599    MININO, ALAN NAHUEL         nminino@fi.uba.ar"<<endl;
    cout<<"99846    TORRESETTI, LISANDRO        ltorresetti@fi.uba.ar"<<endl;
    cout<<"100073   CAROL LUGONES, LUIS IGNACIO icarol@fi.uba.ar"<<endl<<endl;
    
    sv_sem mutex("Mutex");
    sv_sem DI("Simio_cruzando_derecha_a_izquierda");
    sv_sem ID("Simio_cruzando_izquierda_a_derecha");
    sv_shm soga("Soga");
    mutex.del();
    DI.del();
    ID.del();
    cout<<"Semáforos finalizados."<<endl;
    soga.del();
    cout<<"Área compartida liberada."<<endl;
}
