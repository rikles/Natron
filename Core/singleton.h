//  Powiter
//
//  Created by Alexandre Gauthier-Foichat on 06/12
//  Copyright (c) 2013 Alexandre Gauthier-Foichat. All rights reserved.
//  contact: immarespond at gmail dot com

#ifndef PowiterOsX_singleton_h
#define PowiterOsX_singleton_h
#include <cstdlib>
#include <QtCore/QMutex>

// Singleton pattern ( thread-safe) , to have 1 global ptr
// Not used anymore, but left here in case we'd like to use it

template<class T> class Singleton {
    
protected:
    inline explicit Singleton() {
       // _lock = new QMutex;
        Singleton::instance_ = static_cast<T*>(this);
    }
    inline ~Singleton() {
        Singleton::instance_ = 0;
    }
public:
    friend class QMutex;
    
    static T* instance() ;
    static void Destroy();
    static QMutex* _mutex;
    
    
private:
    static T* instance_;
    
    
    inline explicit Singleton(const Singleton&);
    inline Singleton& operator=(const Singleton&){return *this;};
    static T* CreateInstance();
    static void ScheduleForDestruction(void (*)());
    static void DestroyInstance(T*);
    
};

template<class T> T* Singleton<T>::instance() {
    if ( Singleton::instance_ == 0 ) {
        if(_mutex){
            QMutexLocker guard(_mutex);
        }
        if ( Singleton::instance_ == 0 ) {
            Singleton::instance_ = CreateInstance();
            ScheduleForDestruction(Singleton::Destroy);
        }
    }
    return (Singleton::instance_);
}
template<class T> void Singleton<T>::Destroy() {
    if ( Singleton::instance_ != 0 ) {
        DestroyInstance(Singleton::instance_);
        Singleton::instance_ = 0;
    }
}
template<class T> T* Singleton<T>::CreateInstance() {
    return new T();
}
template<class T> void Singleton<T>::ScheduleForDestruction(void (*pFun)()) {
    std::atexit(pFun);
}
template<typename T> void Singleton<T>::DestroyInstance(T* p) {
    delete p;
}

template<class T> T* Singleton<T>::instance_ = 0;
template<class T> QMutex* Singleton<T>::_mutex = 0;


#endif
