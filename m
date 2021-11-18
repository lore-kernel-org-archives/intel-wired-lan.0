From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 18 Nov 2021 00:06:02 +0000
Subject: [Intel-wired-lan] [PATCH linux-next] e1000e: Remove useless
 variables
In-Reply-To: <20211111090712.158901-1-luo.penghao@zte.com.cn>
References: <20211111090712.158901-1-luo.penghao@zte.com.cn>
Message-ID: <9278b8115aab6a1a01987ce62dcd390299477bc1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-11-11 at 09:07 +0000, cgel.zte at gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> This variable is not used in the function.
> 
> The clang_analyzer complains as follows:
> 
> drivers/net/ethernet/intel/e1000e/netdev.c:916:19 warning
> drivers/net/ethernet/intel/e1000e/netdev.c:1310:19 warning
> 
> Value stored to 'hw' during its initialization is never read

This patch also doesn't build:

In file included from ./include/linux/printk.h:555,
                 from ./include/linux/kernel.h:20,
                 from ./arch/x86/include/asm/percpu.h:27,
                 from ./arch/x86/include/asm/current.h:6,
                 from ./arch/x86/include/asm/processor.h:17,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:65,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/net/ethernet/intel/e1000e/netdev.c:6:
drivers/net/ethernet/intel/e1000e/netdev.c: In function
e1000_clean_rx_irq:
drivers/net/ethernet/intel/e1000e/e1000.h:31:20: error: hw undeclared
(first use in this function)
   31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
      |                    ^~
./include/linux/dynamic_debug.h:134:29: note: in definition of macro
__dynamic_func_call
  134 |                 func(&id, ##__VA_ARGS__);               \
      |                             ^~~~~~~~~~~
./include/linux/dynamic_debug.h:170:9: note: in expansion of macro
_dynamic_func_call
  170 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,         
\
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/netdevice.h:4950:9: note: in expansion of macro
dynamic_netdev_dbg
 4950 |         dynamic_netdev_dbg(__dev, format, ##args);            
\
      |         ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/e1000e/e1000.h:31:9: note: in expansion of
macro netdev_dbg
   31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
      |         ^~~~~~~~~~
drivers/net/ethernet/intel/e1000e/netdev.c:970:25: note: in expansion
of macro e_dbg
  970 |                         e_dbg("Receive packet consumed multiple
buffers\n");
      |                         ^~~~~
drivers/net/ethernet/intel/e1000e/e1000.h:31:20: note: each undeclared
identifier is reported only once for each function it appears in
   31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
      |                    ^~
./include/linux/dynamic_debug.h:134:29: note: in definition of macro
__dynamic_func_call
  134 |                 func(&id, ##__VA_ARGS__);               \
      |                             ^~~~~~~~~~~
./include/linux/dynamic_debug.h:170:9: note: in expansion of macro
_dynamic_func_call
  170 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,         
\
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/netdevice.h:4950:9: note: in expansion of macro
dynamic_netdev_dbg
 4950 |         dynamic_netdev_dbg(__dev, format, ##args);            
\
      |         ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/e1000e/e1000.h:31:9: note: in expansion of
macro netdev_dbg
   31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
      |         ^~~~~~~~~~
drivers/net/ethernet/intel/e1000e/netdev.c:970:25: note: in expansion
of macro e_dbg
  970 |                         e_dbg("Receive packet consumed multiple
buffers\n");
      |                         ^~~~~
drivers/net/ethernet/intel/e1000e/netdev.c: In function
e1000_clean_rx_irq_ps:
drivers/net/ethernet/intel/e1000e/e1000.h:31:20: error: hw undeclared
(first use in this function)
   31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
      |                    ^~
./include/linux/dynamic_debug.h:134:29: note: in definition of macro
__dynamic_func_call
  134 |                 func(&id, ##__VA_ARGS__);               \
      |                             ^~~~~~~~~~~
./include/linux/dynamic_debug.h:170:9: note: in expansion of macro
_dynamic_func_call
  170 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,         
\
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/netdevice.h:4950:9: note: in expansion of macro
dynamic_netdev_dbg
 4950 |         dynamic_netdev_dbg(__dev, format, ##args);            
\
      |         ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/e1000e/e1000.h:31:9: note: in expansion of
macro netdev_dbg
   31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
      |         ^~~~~~~~~~
drivers/net/ethernet/intel/e1000e/netdev.c:1356:25: note: in expansion
of macro e_dbg
 1356 |                         e_dbg("Packet Split buffers didn't pick
up the full packet\n");
      |                         ^~~~~


