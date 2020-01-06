From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 6 Jan 2020 20:18:11 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e/iavf: use better trace
 path
In-Reply-To: <20200103022342.820175-1-jesse.brandeburg@intel.com>
References: <20200103022342.820175-1-jesse.brandeburg@intel.com>
Message-ID: <94caf87af5d749bc8748a90f4f46cb50@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, January 2, 2020 6:24 PM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net v2] i40e/iavf: use better trace path
> 
> I'm seeing compilation fail of the i40e/iavf driver for some reason.
> I just checked 5.5-rc4 and the tip of net/net-next and all fail.
> Fails all the way back to v5.1 at least, I didn't check further back.
> 
> repro steps:
> $ gcc -v
> gcc version 9.2.1 20190827 (Red Hat 9.2.1-1) (GCC)
> 
> $ git checkout -b my-net davem-net/master $ make mrproper $ make
> O=../my-net.obj defconfig allmodconfig modules_prepare $ make O=../my-
> net.obj M=drivers/net/ethernet/intel/i40e
> 
> make[1]: Entering directory '/home/jbrandeb/git/my-net.obj'
>   CC [M]  drivers/net/ethernet/intel/i40e/i40e_main.o
> In file included from
> /home/jbrandeb/git/linux2/drivers/net/ethernet/intel/i40e/i40e_trace.h:20
> 9,
>                  from
> /home/jbrandeb/git/linux2/drivers/net/ethernet/intel/i40e/i40e_main.c:20:
> /home/jbrandeb/git/linux2/include/trace/define_trace.h:95:42: fatal error:
> ./i40e_trace.h: No such file or directory
>    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
> compilation terminated.
> make[2]: *** [/home/jbrandeb/git/linux2/scripts/Makefile.build:266:
> drivers/net/ethernet/intel/i40e/i40e_main.o] Error 1
> make[1]: *** [/home/jbrandeb/git/linux2/Makefile:1693:
> drivers/net/ethernet/intel/i40e] Error 2
> make[1]: Leaving directory '/home/jbrandeb/git/my-net.obj'
> make: *** [Makefile:179: sub-make] Error 2
> 
> Just for sanity, I tried building the ice driver the same as above and it
> succeeds, so the build does work for some drivers.
> 
> So fix the include path for the i40e driver trace file to be relative to the kernel
> root like (some) other drivers do.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> ---
> v2: added iavf for the same fix
> ---
>  drivers/net/ethernet/intel/i40e/i40e_trace.h | 2 +-
> drivers/net/ethernet/intel/iavf/iavf_trace.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


