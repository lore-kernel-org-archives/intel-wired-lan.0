From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 19 Oct 2021 08:32:31 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Fix clang -Wimplicit-fallthrough
 in ice_pull_qvec_from_rc()
In-Reply-To: <20211019014203.1926130-1-nathan@kernel.org>
References: <20211019014203.1926130-1-nathan@kernel.org>
Message-ID: <12e0fb52-9853-7115-9699-176de053c641@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/18/2021 6:42 PM, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/net/ethernet/intel/ice/ice_lib.c:1906:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>          default:
>          ^
> drivers/net/ethernet/intel/ice/ice_lib.c:1906:2: note: insert 'break;' to avoid fall-through
>          default:
>          ^
>          break;
> 1 error generated.
> 
> Clang is a little more pedantic than GCC, which does not warn when
> falling through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst, which
> states that all switch/case blocks must end in either break,
> fallthrough, continue, goto, or return. Add the missing break to silence
> the warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1482
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
