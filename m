From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 6 Apr 2022 11:00:15 +0200
Subject: [Intel-wired-lan] [PATCH net 0/2] ixgbe: fix promiscuous mode
 on VF
In-Reply-To: <Yk1MxlsbGi810tgb@arsenic.home>
References: <20220325140250.21663-1-olivier.matz@6wind.com>
 <Yk1MxlsbGi810tgb@arsenic.home>
Message-ID: <d8571528-4202-e6d7-e8b2-f9feb7e6f8f7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Olivier,


Am 06.04.22 um 10:18 schrieb Olivier Matz:

> On Fri, Mar 25, 2022 at 03:02:48PM +0100, Olivier Matz wrote:
>> These 2 patches fix issues related to the promiscuous mode on VF.
>>
>> Comments are welcome,
>> Olivier
>>
>> Cc: stable at vger.kernel.org
>> Cc: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
>> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>>
>> Olivier Matz (2):
>>    ixgbe: fix bcast packets Rx on VF after promisc removal
>>    ixgbe: fix unexpected VLAN Rx in promisc mode on VF
>>
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Sorry, the intel-wired-lan mailing list was not CC'ed initially.
> 
> Please let me know if I need to resend the patchset.

Yes, please resend.


Kind regards,

Paul
