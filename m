From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 Nov 2019 11:04:03 +0800
Subject: [Intel-wired-lan] virtual-bus[v2]: Implementation of Virtual Bus
In-Reply-To: <2B0E3F215D1AB84DA946C8BEE234CCC97B3008AB@ORSMSX101.amr.corp.intel.com>
References: <2B0E3F215D1AB84DA946C8BEE234CCC97B3008AB@ORSMSX101.amr.corp.intel.com>
Message-ID: <201911161033.Xxb9LIsJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.4-rc7 next-20191114]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Ertman-David-M/virtual-bus-v2-Implementation-of-Virtual-Bus/20191116-053518
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git eb70e26cd79da8068dc7a9d013cd78fbba483038
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:6:0,
                    from drivers/bus/virtual_bus.c:11:
   drivers/bus/virtual_bus.c: In function 'virtbus_drv_probe':
>> drivers/bus/virtual_bus.c:223:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
>> drivers/bus/virtual_bus.c:223:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
>> drivers/bus/virtual_bus.c:223:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
>> drivers/bus/virtual_bus.c:223:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:6:0,
                    from drivers/bus/virtual_bus.c:11:
   drivers/bus/virtual_bus.c: In function 'virtbus_drv_remove':
   drivers/bus/virtual_bus.c:244:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers/bus/virtual_bus.c:244:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   drivers/bus/virtual_bus.c:244:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers/bus/virtual_bus.c:244:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:6:0,
                    from drivers/bus/virtual_bus.c:11:
   drivers/bus/virtual_bus.c: In function 'virtbus_drv_shutdown':
   drivers/bus/virtual_bus.c:258:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers/bus/virtual_bus.c:258:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   drivers/bus/virtual_bus.c:258:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers/bus/virtual_bus.c:258:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:6:0,
                    from drivers/bus/virtual_bus.c:11:
   drivers/bus/virtual_bus.c: In function 'virtbus_drv_suspend':
   drivers/bus/virtual_bus.c:267:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers/bus/virtual_bus.c:267:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   drivers/bus/virtual_bus.c:267:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers/bus/virtual_bus.c:267:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:6:0,
                    from drivers/bus/virtual_bus.c:11:
   drivers/bus/virtual_bus.c: In function 'virtbus_drv_resume':
   drivers/bus/virtual_bus.c:278:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers/bus/virtual_bus.c:278:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   drivers/bus/virtual_bus.c:278:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
>> drivers/bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers/bus/virtual_bus.c:278:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
--
   In file included from include/linux/string.h:6:0,
                    from drivers//bus/virtual_bus.c:11:
   drivers//bus/virtual_bus.c: In function 'virtbus_drv_probe':
   drivers//bus/virtual_bus.c:223:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:223:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   drivers//bus/virtual_bus.c:223:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:223:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:6:0,
                    from drivers//bus/virtual_bus.c:11:
   drivers//bus/virtual_bus.c: In function 'virtbus_drv_remove':
   drivers//bus/virtual_bus.c:244:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:244:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   drivers//bus/virtual_bus.c:244:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:244:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:6:0,
                    from drivers//bus/virtual_bus.c:11:
   drivers//bus/virtual_bus.c: In function 'virtbus_drv_shutdown':
   drivers//bus/virtual_bus.c:258:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:258:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   drivers//bus/virtual_bus.c:258:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:258:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:6:0,
                    from drivers//bus/virtual_bus.c:11:
   drivers//bus/virtual_bus.c: In function 'virtbus_drv_suspend':
   drivers//bus/virtual_bus.c:267:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:267:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   drivers//bus/virtual_bus.c:267:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:267:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:6:0,
                    from drivers//bus/virtual_bus.c:11:
   drivers//bus/virtual_bus.c: In function 'virtbus_drv_resume':
   drivers//bus/virtual_bus.c:278:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:278:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   drivers//bus/virtual_bus.c:278:47: error: 'struct virtbus_device' has no member named '_dev'; did you mean 'dev'?
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                                  ^
   include/linux/compiler_types.h:129:57: note: in definition of macro '__compiler_offsetof'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                            ^
>> include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
   drivers//bus/virtual_bus.c:42:29: note: in expansion of macro 'container_of'
    #define to_virtbus_dev(dev) container_of((dev), struct virtbus_device, dev)
                                ^~~~~~~~~~~~
   drivers//bus/virtual_bus.c:278:32: note: in expansion of macro 'to_virtbus_dev'
     struct virtbus_device *vdev = to_virtbus_dev(_dev);
                                   ^~~~~~~~~~~~~~

vim +223 drivers/bus/virtual_bus.c

    41	
  > 42	#define to_virtbus_dev(dev)	container_of((dev), struct virtbus_device, dev)
    43	#define to_virtbus_drv(drv)	(container_of((drv), struct virtbus_driver, \
    44					 driver))
    45	
    46	/**
    47	 * virtbus_match - bind virtbus device to virtbus driver
    48	 * @dev: device
    49	 * @drv: driver
    50	 *
    51	 * Virtbus device IDs are always in "<name>.<instance>" format.
    52	 * Instances are automatically selected through an ida_simple_get so
    53	 * are positive integers. Names are taken from the device name field.
    54	 * Driver IDs are simple <name>.  Need to extract the name from the
    55	 * Virtual Device compare to name of the driver.
    56	 */
    57	static int virtbus_match(struct device *dev, struct device_driver *drv)
    58	{
    59		struct virtbus_driver *vdrv = to_virtbus_drv(drv);
    60		struct virtbus_device *vdev = to_virtbus_dev(dev);
    61	
    62		if (vdrv->id_table)
    63			return virtbus_match_id(vdrv->id_table, vdev) != NULL;
    64	
    65		return !strcmp(vdev->name, drv->name);
    66	}
    67	
    68	/**
    69	 * virtbus_probe - call probe of the virtbus_drv
    70	 * @dev: device struct
    71	 */
    72	static int virtbus_probe(struct device *dev)
    73	{
    74		if (dev->driver->probe)
    75			return dev->driver->probe(dev);
    76	
    77		return 0;
    78	}
    79	
    80	static int virtbus_remove(struct device *dev)
    81	{
    82		if (dev->driver->remove)
    83			return dev->driver->remove(dev);
    84	
    85		return 0;
    86	}
    87	
    88	static void virtbus_shutdown(struct device *dev)
    89	{
    90		if (dev->driver->shutdown)
    91			dev->driver->shutdown(dev);
    92	}
    93	
    94	static int virtbus_suspend(struct device *dev, pm_message_t state)
    95	{
    96		if (dev->driver->suspend)
    97			return dev->driver->suspend(dev, state);
    98	
    99		return 0;
   100	}
   101	
   102	static int virtbus_resume(struct device *dev)
   103	{
   104		if (dev->driver->resume)
   105			return dev->driver->resume(dev);
   106	
   107		return 0;
   108	}
   109	
   110	struct bus_type virtual_bus_type = {
   111		.name		= "virtbus",
   112		.match		= virtbus_match,
   113		.probe		= virtbus_probe,
   114		.remove		= virtbus_remove,
   115		.shutdown	= virtbus_shutdown,
   116		.suspend	= virtbus_suspend,
   117		.resume		= virtbus_resume,
   118	};
   119	
   120	/**
   121	 * virtbus_dev_register - add a virtual bus device
   122	 * @vdev: virtual bus device to add
   123	 */
   124	int virtbus_dev_register(struct virtbus_device *vdev)
   125	{
   126		int ret;
   127	
   128		if (!vdev)
   129			return -EINVAL;
   130	
   131		device_initialize(&vdev->dev);
   132	
   133		vdev->dev.bus = &virtual_bus_type;
   134		/* All device IDs are automatically allocated */
   135		ret = ida_simple_get(&virtbus_dev_ida, 0, 0, GFP_KERNEL);
   136		if (ret < 0)
   137			return ret;
   138	
   139		vdev->id = ret;
   140		dev_set_name(&vdev->dev, "%s.%d", vdev->name, vdev->id);
   141	
   142		dev_dbg(&vdev->dev, "Registering VirtBus device '%s'\n",
   143			dev_name(&vdev->dev));
   144	
   145		ret = device_add(&vdev->dev);
   146		if (!ret)
   147			return ret;
   148	
   149		/* Error adding virtual device */
   150		device_del(&vdev->dev);
   151		ida_simple_remove(&virtbus_dev_ida, vdev->id);
   152		vdev->id = VIRTBUS_DEVID_NONE;
   153	
   154		return ret;
   155	}
   156	EXPORT_SYMBOL_GPL(virtbus_dev_register);
   157	
   158	/**
   159	 * virtbus_dev_unregister - remove a virtual bus device
   160	 * vdev: virtual bus device we are removing
   161	 */
   162	void virtbus_dev_unregister(struct virtbus_device *vdev)
   163	{
   164		if (!IS_ERR_OR_NULL(vdev)) {
   165			device_del(&vdev->dev);
   166	
   167			ida_simple_remove(&virtbus_dev_ida, vdev->id);
   168			vdev->id = VIRTBUS_DEVID_NONE;
   169		}
   170	}
   171	EXPORT_SYMBOL_GPL(virtbus_dev_unregister);
   172	
   173	struct virtbus_object {
   174		struct virtbus_device vdev;
   175		char name[];
   176	};
   177	
   178	/**
   179	 * virtbus_dev_release - Destroy a virtbus device
   180	 * @vdev: virtual device to release
   181	 *
   182	 * Note that the vdev->data which is separately allocated needs to be
   183	 * separately freed on it own.
   184	 */
   185	static void virtbus_dev_release(struct device *dev)
   186	{
   187		struct virtbus_object *vo = container_of(dev, struct virtbus_object,
   188							 vdev.dev);
   189	
   190		kfree(vo);
   191	}
   192	
   193	/**
   194	 * virtbus_dev_alloc - allocate a virtbus device
   195	 * @name: name to associate with the vdev
   196	 * @data: pointer to data to be associated with this device
   197	 */
   198	struct virtbus_device *virtbus_dev_alloc(const char *name, void *data)
   199	{
   200		struct virtbus_object *vo;
   201	
   202		/* Create a virtbus object to contain the vdev and name.  This
   203		 * avoids a problem with the const attribute of name in the vdev.
   204		 * The virtbus_object will be allocated here and freed in the
   205		 * release function.
   206		 */
   207		vo = kzalloc(sizeof(*vo) + strlen(name) + 1, GFP_KERNEL);
   208		if (!vo)
   209			return NULL;
   210	
   211		strcpy(vo->name, name);
   212		vo->vdev.name = vo->name;
   213		vo->vdev.data = data;
   214		vo->vdev.dev.release = virtbus_dev_release;
   215	
   216		return &vo->vdev;
   217	}
   218	EXPORT_SYMBOL_GPL(virtbus_dev_alloc);
   219	
   220	static int virtbus_drv_probe(struct device *_dev)
   221	{
   222		struct virtbus_driver *vdrv = to_virtbus_drv(_dev->driver);
 > 223		struct virtbus_device *vdev = to_virtbus_dev(_dev);
   224		int ret;
   225	
   226		ret = dev_pm_domain_attach(_dev, true);
   227		if (ret) {
   228			dev_warn(_dev, "Failed to attatch to PM Domain : %d\n", ret);
   229			return ret;
   230		}
   231	
   232		if (vdrv->probe) {
   233			ret = vdrv->probe(vdev);
   234			if (ret)
   235				dev_pm_domain_detach(_dev, true);
   236		}
   237	
   238		return ret;
   239	}
   240	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54964 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191116/5a66b961/attachment-0001.bin>
