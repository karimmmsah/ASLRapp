/****************************************************************************
** Meta object code from reading C++ file 'Keychain.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.5.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../Keychain.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Keychain.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSKeychainENDCLASS_t {};
static constexpr auto qt_meta_stringdata_CLASSKeychainENDCLASS = QtMocHelpers::stringData(
    "Keychain",
    "storeCredentials",
    "",
    "username",
    "password",
    "retrieveUsername",
    "retrievePassword"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSKeychainENDCLASS_t {
    uint offsetsAndSizes[14];
    char stringdata0[9];
    char stringdata1[17];
    char stringdata2[1];
    char stringdata3[9];
    char stringdata4[9];
    char stringdata5[17];
    char stringdata6[17];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSKeychainENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSKeychainENDCLASS_t qt_meta_stringdata_CLASSKeychainENDCLASS = {
    {
        QT_MOC_LITERAL(0, 8),  // "Keychain"
        QT_MOC_LITERAL(9, 16),  // "storeCredentials"
        QT_MOC_LITERAL(26, 0),  // ""
        QT_MOC_LITERAL(27, 8),  // "username"
        QT_MOC_LITERAL(36, 8),  // "password"
        QT_MOC_LITERAL(45, 16),  // "retrieveUsername"
        QT_MOC_LITERAL(62, 16)   // "retrievePassword"
    },
    "Keychain",
    "storeCredentials",
    "",
    "username",
    "password",
    "retrieveUsername",
    "retrievePassword"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSKeychainENDCLASS[] = {

 // content:
      11,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       1,    2,   32,    2, 0x02,    1 /* Public */,
       5,    0,   37,    2, 0x02,    4 /* Public */,
       6,    0,   38,    2, 0x02,    5 /* Public */,

 // methods: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    3,    4,
    QMetaType::QString,
    QMetaType::QString,

       0        // eod
};

Q_CONSTINIT const QMetaObject Keychain::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSKeychainENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSKeychainENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSKeychainENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<Keychain, std::true_type>,
        // method 'storeCredentials'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'retrieveUsername'
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'retrievePassword'
        QtPrivate::TypeAndForceComplete<QString, std::false_type>
    >,
    nullptr
} };

void Keychain::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Keychain *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->storeCredentials((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 1: { QString _r = _t->retrieveUsername();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 2: { QString _r = _t->retrievePassword();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

const QMetaObject *Keychain::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Keychain::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSKeychainENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Keychain::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 3;
    }
    return _id;
}
QT_WARNING_POP
