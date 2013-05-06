#include "Core/row.h"
#include "Core/node.h"

Row::Row(){
    buffers = 0;
}

void Row::turn_on(Channel c){
    _channels += c;
    buffers[c] = (float*)malloc((r-x)*sizeof(float));
}



Row::Row(int x,int y, int range, ChannelSet channels)
{
    this->x=x;
	this->_y=y;
    this->r=range;
    _channels = channels;
    buffers = (float**)malloc(MAX_BUFFERS_PER_ROW*sizeof(float*));
    memset(buffers, 0, sizeof(float*)*MAX_BUFFERS_PER_ROW);
    init();
}
void Row::init(){
    foreachChannels(z, _channels){
        buffers[z] = (float*)malloc((r-x)*sizeof(float));
    }    
}

void Row::changeSize(int offset,int range){
    //TODO : change the name of the function to reflect its behaviour
    if((range-offset) < (r-x)) // don't changeSize if the range is smaller
        return;
    r = range;
    x = offset;
    foreachChannels(z, _channels){
        buffers[(int)z] = (float*)realloc(buffers[(int)z],(r-x)*sizeof(float));
    }
   
}

Row::~Row(){
    for(unsigned int i =0; i < channels().size();i++){
        free(buffers[i]);
    }
    free(buffers);
}
const float* Row::operator[](Channel z) const{
    if(buffers[z]){
        return buffers[z] - x ;
    }else{
        return NULL;
    }
    
}

float* Row::writable(Channel c){
    if(buffers[c]){
        return buffers[c] - x ;
    }else{
        return NULL;
    }
}
void Row::copy(const Row *source,ChannelSet channels,int o,int r){
    changeSize(o, r); // does nothing if the range is smaller
    foreachChannels(z, channels){
        if(!buffers[z]){
            turn_on(z);
        }
        const float* sourcePtr = (*source)[z] + o;
        float* to = buffers[z] -x + o;
        float* end = to + r;
        while(to!=end) *to++ = *sourcePtr++;
    }
}
void Row::erase(Channel c){
    if(buffers[c])
        memset(buffers[c], 0, sizeof(float)*(r-x));
}


void Row::get(Node &input,int y,int x,int range,ChannelSet channels){

    
    cout << " NOT YET IMPLEMENTED " << endl;


}
bool compareRows(const Row &a,const Row &b){
    if (a.y()<=b.y()){
        return true;
    }else{
        return false;
    }
}

