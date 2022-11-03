

Function sysmainDisable(){
    net.exe stop sysmain
    sc.exe config sysmain start=disabled
}
