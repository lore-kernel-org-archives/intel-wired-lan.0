From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Fri, 7 Aug 2015 15:22:23 +0900
Subject: [Intel-wired-lan] [PATCH next 3/4] ixgbe: Enable TSO for
	stacked vlan
In-Reply-To: <1438927643.2990.2.camel@intel.com>
References: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <1438851452-13143-3-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <1438927643.2990.2.camel@intel.com>
Message-ID: <55C44E9F.9010202@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015/08/07 15:07, Jeff Kirsher wrote:
> On Thu, 2015-08-06 at 17:57 +0900, Toshiaki Makita wrote:
>> Setting ndo_features_check to passthru_features_check allows the
>> driver
>> to skip the check for multiple tagged TSO packets and enables stacked
>> vlan TSO.
>> Tested with 82599ES.
>>
>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> NACK!
> 
> This does not apply cleanly AND the ixgbe code already has
> a .ndo_features_check which is assigned to our ixgbe_features_check().
> 
> PLEASE pull my tree to ensure you are using the latest code when
> generating patches.

Oops...
I tested patches on next-queue's "master" branch but I now realize I
should have tested on "dev-queue" branch..

I'm sorry, this patch is completely unnecessary since
ixgbe_features_check() doesn't call vlan_check_features().

Toshiaki Makita

