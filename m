From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Jan 2018 17:20:12 +0100
Subject: [Intel-wired-lan] [PATCH] [RESEND net] fm10k: mark PM functions
 as __maybe_unused
In-Reply-To: <02874ECE860811409154E81DA85FBB5882BD2802@fmsmsx158.amr.corp.intel.com>
References: <20180116091433.2535569-1-arnd@arndb.de>
 <02874ECE860811409154E81DA85FBB5882BD2802@fmsmsx158.amr.corp.intel.com>
Message-ID: <CAK8P3a27iQWGzwfDOMLj-sVquiHNPccAp0_8-2zoaqQVB0K44g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 16, 2018 at 5:12 PM, Keller, Jacob E
<jacob.e.keller@intel.com> wrote:
>> -----Original Message-----
>> From: Arnd Bergmann [mailto:arnd at arndb.de]
>> Sent: Tuesday, January 16, 2018 1:14 AM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>; Keller, Jacob E
>> <jacob.e.keller@intel.com>; David S. Miller <davem@davemloft.net>; Kwan,
>> Ngai-mint <ngai-mint.kwan@intel.com>; intel-wired-lan at lists.osuosl.org;
>> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
>> Subject: [PATCH] [RESEND net] fm10k: mark PM functions as __maybe_unused
>>
>> A cleanup of the PM code left an incorrect #ifdef in place, leading
>> to a harmless build warning:
>>
>> drivers/net/ethernet/intel/fm10k/fm10k_pci.c:2502:12: error: 'fm10k_suspend'
>> defined but not used [-Werror=unused-function]
>> drivers/net/ethernet/intel/fm10k/fm10k_pci.c:2475:12: error: 'fm10k_resume'
>> defined but not used [-Werror=unused-function]
>>
>> It's easier to use __maybe_unused attributes here, since you
>> can't pick the wrong one.
>>
>> Fixes: 8249c47c6ba4 ("fm10k: use generic PM hooks instead of legacy PCIe power
>> hooks")
>> Acked-by: Jacob Keller <jacob.e.keller@intel.com>
>> Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> Apparently nobody picked this up the first time around (Oct 2017),
>> here is the same patch again.
>
> Odd. I remember seeing this and thought I ack'd it..? Guess it got missed.
>
> Acked-by: Jacob Keller <jacob.e.keller@intel.com>

Yes, you did give an Ack (see above), it's just that it didn't make it
into the tree for some reason. Maybe Jeff assumed you would
forward it to him and you thought that he would pick it up from the
list?

      Arnd
