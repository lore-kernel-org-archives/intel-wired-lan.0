From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Date: Fri, 22 May 2020 12:20:57 +0900
Subject: [Intel-wired-lan] [PATCH] e1000e: Relax condition to trigger
 reset for ME workaround
In-Reply-To: <DM6PR11MB2890F48ACD9A4ECF9181A819BCB70@DM6PR11MB2890.namprd11.prod.outlook.com>
 (Aaron F. Brown's message of "Thu, 21 May 2020 07:56:12 +0000")
References: <20200515043127.3882162-1-punit1.agrawal@toshiba.co.jp>
 <DM6PR11MB2890F48ACD9A4ECF9181A819BCB70@DM6PR11MB2890.namprd11.prod.outlook.com>
Message-ID: <87367sac4m.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Aaron,

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:

>> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org> On
>> Behalf Of Punit Agrawal
>> Sent: Thursday, May 14, 2020 9:31 PM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>> Cc: daniel.sangorrin at toshiba.co.jp; Punit Agrawal
>> <punit1.agrawal@toshiba.co.jp>; Alexander Duyck
>> <alexander.h.duyck@linux.intel.com>; David S. Miller <davem@davemloft.net>;
>> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
>> kernel at vger.kernel.org
>> Subject: [PATCH] e1000e: Relax condition to trigger reset for ME workaround
>> 
>> It's an error if the value of the RX/TX tail descriptor does not match
>> what was written. The error condition is true regardless the duration
>> of the interference from ME. But the driver only performs the reset if
>> E1000_ICH_FWSM_PCIM2PCI_COUNT (2000) iterations of 50us delay have
>> transpired. The extra condition can lead to inconsistency between the
>> state of hardware as expected by the driver.
>> 
>> Fix this by dropping the check for number of delay iterations.
>> 
>> While at it, also make __ew32_prepare() static as it's not used
>> anywhere else.
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: intel-wired-lan at lists.osuosl.org
>> Cc: netdev at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> ---
>> Hi Jeff,
>> 
>> If there are no further comments please consider merging the patch.
>> 
>> Also, should it be marked for backport to stable?
>> 
>> Thanks,
>> Punit
>> 
>> RFC[0] -> v1:
>> * Dropped return value for __ew32_prepare() as it's not used
>> * Made __ew32_prepare() static
>> * Added tags
>> 
>> [0] https://lkml.org/lkml/2020/5/12/20
>> 
>>  drivers/net/ethernet/intel/e1000e/e1000.h  |  1 -
>>  drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++-------
>>  2 files changed, 5 insertions(+), 8 deletions(-)
>> 
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Thanks for taking the patch for a spin.

Jeff, let me know if you're okay to apply the tag or want me to send a
new version.

Thanks,
Punit

