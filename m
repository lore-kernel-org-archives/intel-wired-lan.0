From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 8 Jan 2020 14:49:39 -0800
Subject: [Intel-wired-lan] [PATCH net v2] i40e/iavf: use better trace
 path
In-Reply-To: <20200103022342.820175-1-jesse.brandeburg@intel.com>
References: <20200103022342.820175-1-jesse.brandeburg@intel.com>
Message-ID: <4185adba-3420-32ad-014d-64eee768d183@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/2/2020 6:23 PM, Jesse Brandeburg wrote:
> I'm seeing compilation fail of the i40e/iavf driver for some reason.
> I just checked 5.5-rc4 and the tip of net/net-next and all fail.
> Fails all the way back to v5.1 at least, I didn't check further back.
> 
> repro steps:
> $ gcc -v
> gcc version 9.2.1 20190827 (Red Hat 9.2.1-1) (GCC)
> 
> $ git checkout -b my-net davem-net/master
> $ make mrproper
> $ make O=../my-net.obj defconfig allmodconfig modules_prepare
> $ make O=../my-net.obj M=drivers/net/ethernet/intel/i40e
> 
> make[1]: Entering directory '/home/jbrandeb/git/my-net.obj'
>   CC [M]  drivers/net/ethernet/intel/i40e/i40e_main.o
> In file included from
> /home/jbrandeb/git/linux2/drivers/net/ethernet/intel/i40e/i40e_trace.h:209,
>                  from /home/jbrandeb/git/linux2/drivers/net/ethernet/intel/i40e/i40e_main.c:20:
> /home/jbrandeb/git/linux2/include/trace/define_trace.h:95:42: fatal error: ./i40e_trace.h: No such file or directory
>    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
> compilation terminated.
> make[2]: *** [/home/jbrandeb/git/linux2/scripts/Makefile.build:266: drivers/net/ethernet/intel/i40e/i40e_main.o] Error 1
> make[1]: *** [/home/jbrandeb/git/linux2/Makefile:1693: drivers/net/ethernet/intel/i40e] Error 2
> make[1]: Leaving directory '/home/jbrandeb/git/my-net.obj'
> make: *** [Makefile:179: sub-make] Error 2
> 
> Just for sanity, I tried building the ice driver the same as above and
> it succeeds, so the build does work for some drivers.
> 

So.. ice works for some reason but i40e and iavf do not? Is the ice
driver using a path relative to the root?

> So fix the include path for the i40e driver trace file to be relative
> to the kernel root like (some) other drivers do.

I'd really like to know why this isn't required by all drivers...

> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> ---
> v2: added iavf for the same fix
> ---
>  drivers/net/ethernet/intel/i40e/i40e_trace.h | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_trace.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
> index 424f02077e2e..122a3fcb62b1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
> @@ -203,7 +203,7 @@ DEFINE_EVENT(
>   * module.
>   */
>  #undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_PATH ../../drivers/net/ethernet/intel/i40e
>  #undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE i40e_trace
>  #include <trace/define_trace.h>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_trace.h b/drivers/net/ethernet/intel/iavf/iavf_trace.h
> index 1058e68a02b4..b2674c935c21 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_trace.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_trace.h
> @@ -203,7 +203,7 @@ DEFINE_EVENT(
>   * module.
>   */
>  #undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_PATH ../../drivers/net/ethernet/intel/iavf
>  #undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE iavf_trace
>  #include <trace/define_trace.h>
> 
