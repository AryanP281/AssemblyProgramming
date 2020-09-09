
#include<iostream>

using namespace std;

//extern "C" int SomeFunction();
//extern "C" int registersTest();
extern "C" int addTestFunc();


int main()
{
	cout << "Result is : " << addTestFunc();
	
	//cout << registersTest();

	return 0;
}