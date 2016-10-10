int main() {

    int size;
    bool ar[2];
    int la; int pa;


    ar[0] = true;
    ar[1] = false;

    size = 4;
    pa = (5 + size) / 3;
    la = pa % size;
    la = la + (ar[0] * ar[1]);
}