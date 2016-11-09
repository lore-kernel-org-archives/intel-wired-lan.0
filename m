From: maowenan <maowenan@huawei.com>
Date: Wed, 9 Nov 2016 09:43:36 +0000
Subject: [Intel-wired-lan] =?utf-8?b?562U5aSNOiBbUEFUQ0hdIGFkZCBvbmUgcGFy?=
 =?utf-8?q?ameter_wro=5Fenable_to_enable_relaxed_ordering_for_IXGBE?=
In-Reply-To: <1477726941.2309.9.camel@intel.com>
References: <1477724932-5440-1-git-send-email-maowenan@huawei.com>
 <1477726941.2309.9.camel@intel.com>
Message-ID: <F95AC9340317A84688A5F0DF0246F3F2A766D3@szxeml504-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I have verified that the performance will be enhanced certainly when I enabled Relax Ordering on SPARC, but think it is not very flexible to disable or enable Relax Ordering feature using CONFIG_SPARC currently,
So I want to use module parameter to set RO instead of "#ifndef CONFIG_SPARC", no need to rebuild the whole kernel.


-----????-----
???: Jeff Kirsher [mailto:jeffrey.t.kirsher at intel.com] 
????: 2016?10?29? 15:42
???: maowenan; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org
??: Re: [PATCH] add one parameter wro_enable to enable relaxed ordering for IXGBE

On Sat, 2016-10-29 at 15:08 +0800, Mao Wenan wrote:
> This patch provides a way to enable relaxed ordering, where it helps 
> with performance in some architecture.
> The default value of wro_enable is 0, if you want to enable relaxed 
> ordering, please set wro_enable=1.
> 
> Mao Wenan (1):
> ? add one parameter wro_enable for IXGBE
> 
> ?drivers/net/ethernet/intel/ixgbe/ixgbe.h??????? |? 1 +
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c? | 29 
> ++++++++++++++-----
> ------
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 28 
> +++++++++++++----
> -------
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c?? |? 9 ++++++++
> ?4 files changed, 41 insertions(+), 26 deletions(-)

Why have a title patch for only one patch? ?Better yet, the one patch does not have a patch description. ?Get rid of the title patch and add the above information into the patches description.

In addition, module parameters are not kindly looked upon, one reason is that it cannot be standardized and enforced.

I am also confused because you are stating that on some architectures, yet this code is only compiled in when SPARC is defined and that there are times when you want relaxed ordering enabled and other times disabled?
?Your gonna have to provide more data on why, because the code as is was resolving serious performance issues on SPARC when relaxed ordering was enabled.
