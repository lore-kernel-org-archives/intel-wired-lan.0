From: David Miller <davem@davemloft.net>
Date: Wed, 19 May 2021 12:23:56 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next 0/5] net: intel: some cleanups
In-Reply-To: <194cf154afa7b56b22d4284cad537f1a6b697f61.camel@intel.com>
References: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
 <194cf154afa7b56b22d4284cad537f1a6b697f61.camel@intel.com>
Message-ID: <20210519.122356.1201315264426214403.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Date: Wed, 19 May 2021 18:48:51 +0000

> On Wed, 2021-05-19 at 14:14 +0800, Guangbin Huang wrote:
>> This patchset adds some cleanups for intel e1000/e1000e ethernet
>> driver.
>> 
>> Hao Chen (5):
>>   net: e1000: remove repeated word "slot" for e1000_main.c
>>   net: e1000: remove repeated words for e1000_hw.c
>>   net: e1000e: remove repeated word "the" for ich8lan.c
>>   net: e1000e: remove repeated word "slot" for netdev.c
>>   net: e1000e: fix misspell word "retreived"
>> 
>>  drivers/net/ethernet/intel/e1000/e1000_hw.c   | 4 ++--
>>  drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
>>  drivers/net/ethernet/intel/e1000e/ich8lan.c   | 2 +-
>>  drivers/net/ethernet/intel/e1000e/netdev.c    | 2 +-
>>  drivers/net/ethernet/intel/e1000e/phy.c       | 2 +-
>>  5 files changed, 6 insertions(+), 6 deletions(-)
>> 
> 
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Dave/Jakub - as these are just comment changes, did you want to pick
> this up?

Sure.
