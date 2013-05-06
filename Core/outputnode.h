#ifndef OUTPUTNODE_H
#define OUTPUTNODE_H
#include "Core/node.h"


class Model;
class OutputNode : public Node
{
public:

    OutputNode(OutputNode& ref):Node(ref){_currentFrame=-1;}
    OutputNode(Node* node);
   
    virtual ~OutputNode(){}
    
    virtual bool hasOutput(){return false;}
    virtual bool isOutputNode(){return true;}
    virtual void setOutputNb(){freeOutputNb=0;}
    virtual int inputs(){return 1;}
   
	int currentFrame(){return _currentFrame;}
	void currentFrame(int c){_currentFrame=c;}

protected:
    int _currentFrame;
private:


    


};


#endif // OUTPUTNODE_H
