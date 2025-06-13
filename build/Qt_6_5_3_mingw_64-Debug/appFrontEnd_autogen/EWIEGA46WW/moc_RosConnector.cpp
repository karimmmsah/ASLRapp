/****************************************************************************
** Meta object code from reading C++ file 'RosConnector.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.5.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../RosConnector.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'RosConnector.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.5.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSRosConnectorENDCLASS_t {};
static constexpr auto qt_meta_stringdata_CLASSRosConnectorENDCLASS = QtMocHelpers::stringData(
    "RosConnector",
    "connectedToRos",
    "",
    "connectionFailed",
    "connectionStatusChanged",
    "poseReceived",
    "json",
    "mapReceived",
    "globalPathReceived",
    "localPathReceived",
    "goalReceived",
    "costmapReceived",
    "cmdVelReceived",
    "twistJson",
    "hoverboardCmdVelReceived",
    "batteryVoltageReceived",
    "voltageJson",
    "onConnected",
    "onDisconnected",
    "connectToRos",
    "goToChargingStation",
    "sendMessage",
    "message",
    "sendGoal",
    "x",
    "y",
    "setRosIp",
    "ip",
    "isConnected"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSRosConnectorENDCLASS_t {
    uint offsetsAndSizes[58];
    char stringdata0[13];
    char stringdata1[15];
    char stringdata2[1];
    char stringdata3[17];
    char stringdata4[24];
    char stringdata5[13];
    char stringdata6[5];
    char stringdata7[12];
    char stringdata8[19];
    char stringdata9[18];
    char stringdata10[13];
    char stringdata11[16];
    char stringdata12[15];
    char stringdata13[10];
    char stringdata14[25];
    char stringdata15[23];
    char stringdata16[12];
    char stringdata17[12];
    char stringdata18[15];
    char stringdata19[13];
    char stringdata20[20];
    char stringdata21[12];
    char stringdata22[8];
    char stringdata23[9];
    char stringdata24[2];
    char stringdata25[2];
    char stringdata26[9];
    char stringdata27[3];
    char stringdata28[12];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSRosConnectorENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSRosConnectorENDCLASS_t qt_meta_stringdata_CLASSRosConnectorENDCLASS = {
    {
        QT_MOC_LITERAL(0, 12),  // "RosConnector"
        QT_MOC_LITERAL(13, 14),  // "connectedToRos"
        QT_MOC_LITERAL(28, 0),  // ""
        QT_MOC_LITERAL(29, 16),  // "connectionFailed"
        QT_MOC_LITERAL(46, 23),  // "connectionStatusChanged"
        QT_MOC_LITERAL(70, 12),  // "poseReceived"
        QT_MOC_LITERAL(83, 4),  // "json"
        QT_MOC_LITERAL(88, 11),  // "mapReceived"
        QT_MOC_LITERAL(100, 18),  // "globalPathReceived"
        QT_MOC_LITERAL(119, 17),  // "localPathReceived"
        QT_MOC_LITERAL(137, 12),  // "goalReceived"
        QT_MOC_LITERAL(150, 15),  // "costmapReceived"
        QT_MOC_LITERAL(166, 14),  // "cmdVelReceived"
        QT_MOC_LITERAL(181, 9),  // "twistJson"
        QT_MOC_LITERAL(191, 24),  // "hoverboardCmdVelReceived"
        QT_MOC_LITERAL(216, 22),  // "batteryVoltageReceived"
        QT_MOC_LITERAL(239, 11),  // "voltageJson"
        QT_MOC_LITERAL(251, 11),  // "onConnected"
        QT_MOC_LITERAL(263, 14),  // "onDisconnected"
        QT_MOC_LITERAL(278, 12),  // "connectToRos"
        QT_MOC_LITERAL(291, 19),  // "goToChargingStation"
        QT_MOC_LITERAL(311, 11),  // "sendMessage"
        QT_MOC_LITERAL(323, 7),  // "message"
        QT_MOC_LITERAL(331, 8),  // "sendGoal"
        QT_MOC_LITERAL(340, 1),  // "x"
        QT_MOC_LITERAL(342, 1),  // "y"
        QT_MOC_LITERAL(344, 8),  // "setRosIp"
        QT_MOC_LITERAL(353, 2),  // "ip"
        QT_MOC_LITERAL(356, 11)   // "isConnected"
    },
    "RosConnector",
    "connectedToRos",
    "",
    "connectionFailed",
    "connectionStatusChanged",
    "poseReceived",
    "json",
    "mapReceived",
    "globalPathReceived",
    "localPathReceived",
    "goalReceived",
    "costmapReceived",
    "cmdVelReceived",
    "twistJson",
    "hoverboardCmdVelReceived",
    "batteryVoltageReceived",
    "voltageJson",
    "onConnected",
    "onDisconnected",
    "connectToRos",
    "goToChargingStation",
    "sendMessage",
    "message",
    "sendGoal",
    "x",
    "y",
    "setRosIp",
    "ip",
    "isConnected"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSRosConnectorENDCLASS[] = {

 // content:
      11,       // revision
       0,       // classname
       0,    0, // classinfo
      19,   14, // methods
       1,  173, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      12,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,  128,    2, 0x06,    2 /* Public */,
       3,    0,  129,    2, 0x06,    3 /* Public */,
       4,    0,  130,    2, 0x06,    4 /* Public */,
       5,    1,  131,    2, 0x06,    5 /* Public */,
       7,    1,  134,    2, 0x06,    7 /* Public */,
       8,    1,  137,    2, 0x06,    9 /* Public */,
       9,    1,  140,    2, 0x06,   11 /* Public */,
      10,    1,  143,    2, 0x06,   13 /* Public */,
      11,    1,  146,    2, 0x06,   15 /* Public */,
      12,    1,  149,    2, 0x06,   17 /* Public */,
      14,    1,  152,    2, 0x06,   19 /* Public */,
      15,    1,  155,    2, 0x06,   21 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
      17,    0,  158,    2, 0x08,   23 /* Private */,
      18,    0,  159,    2, 0x08,   24 /* Private */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
      19,    0,  160,    2, 0x02,   25 /* Public */,
      20,    0,  161,    2, 0x02,   26 /* Public */,
      21,    1,  162,    2, 0x02,   27 /* Public */,
      23,    2,  165,    2, 0x02,   29 /* Public */,
      26,    1,  170,    2, 0x02,   32 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void, QMetaType::QString,   13,
    QMetaType::Void, QMetaType::QString,   13,
    QMetaType::Void, QMetaType::QString,   16,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   22,
    QMetaType::Void, QMetaType::Double, QMetaType::Double,   24,   25,
    QMetaType::Void, QMetaType::QString,   27,

 // properties: name, type, flags
      28, QMetaType::Bool, 0x00015001, uint(2), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject RosConnector::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSRosConnectorENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSRosConnectorENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSRosConnectorENDCLASS_t,
        // property 'isConnected'
        QtPrivate::TypeAndForceComplete<bool, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<RosConnector, std::true_type>,
        // method 'connectedToRos'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'connectionFailed'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'connectionStatusChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'poseReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'mapReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'globalPathReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'localPathReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'goalReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'costmapReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'cmdVelReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'hoverboardCmdVelReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'batteryVoltageReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'onConnected'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'onDisconnected'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'connectToRos'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'goToChargingStation'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'sendMessage'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'sendGoal'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        // method 'setRosIp'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>
    >,
    nullptr
} };

void RosConnector::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<RosConnector *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->connectedToRos(); break;
        case 1: _t->connectionFailed(); break;
        case 2: _t->connectionStatusChanged(); break;
        case 3: _t->poseReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 4: _t->mapReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 5: _t->globalPathReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 6: _t->localPathReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 7: _t->goalReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 8: _t->costmapReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 9: _t->cmdVelReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 10: _t->hoverboardCmdVelReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 11: _t->batteryVoltageReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 12: _t->onConnected(); break;
        case 13: _t->onDisconnected(); break;
        case 14: _t->connectToRos(); break;
        case 15: _t->goToChargingStation(); break;
        case 16: _t->sendMessage((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 17: _t->sendGoal((*reinterpret_cast< std::add_pointer_t<double>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[2]))); break;
        case 18: _t->setRosIp((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (RosConnector::*)();
            if (_t _q_method = &RosConnector::connectedToRos; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)();
            if (_t _q_method = &RosConnector::connectionFailed; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)();
            if (_t _q_method = &RosConnector::connectionStatusChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)(const QString & );
            if (_t _q_method = &RosConnector::poseReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)(const QString & );
            if (_t _q_method = &RosConnector::mapReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)(const QString & );
            if (_t _q_method = &RosConnector::globalPathReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)(const QString & );
            if (_t _q_method = &RosConnector::localPathReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)(const QString & );
            if (_t _q_method = &RosConnector::goalReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 7;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)(const QString & );
            if (_t _q_method = &RosConnector::costmapReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 8;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)(const QString & );
            if (_t _q_method = &RosConnector::cmdVelReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 9;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)(const QString & );
            if (_t _q_method = &RosConnector::hoverboardCmdVelReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 10;
                return;
            }
        }
        {
            using _t = void (RosConnector::*)(const QString & );
            if (_t _q_method = &RosConnector::batteryVoltageReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 11;
                return;
            }
        }
    }else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<RosConnector *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->isConnected(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
}

const QMetaObject *RosConnector::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *RosConnector::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSRosConnectorENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int RosConnector::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 19)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 19;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 19)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 19;
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    return _id;
}

// SIGNAL 0
void RosConnector::connectedToRos()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void RosConnector::connectionFailed()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void RosConnector::connectionStatusChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void RosConnector::poseReceived(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void RosConnector::mapReceived(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void RosConnector::globalPathReceived(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void RosConnector::localPathReceived(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void RosConnector::goalReceived(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void RosConnector::costmapReceived(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void RosConnector::cmdVelReceived(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}

// SIGNAL 10
void RosConnector::hoverboardCmdVelReceived(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 10, _a);
}

// SIGNAL 11
void RosConnector::batteryVoltageReceived(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 11, _a);
}
QT_WARNING_POP
