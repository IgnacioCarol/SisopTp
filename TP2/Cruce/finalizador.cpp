#include <iostream>
#include "../Sem-sv/sv_sem.h"
#include "../Sem-sv/sv_shm.h"
using namespace std;

int main(int argc, char * argv[]){
    sv_sem mutex("Mutex");
    sv_sem simios_cruzando("Simios Cruzando");
    sv_shm soga("Soga");
    mutex.del();
    simios_cruzando.del();
    soga.del();
}
