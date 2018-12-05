From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 5 Dec 2018 14:13:28 -0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 14/17] ERROR:
 "mdiobus_unregister" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
In-Reply-To: <44210b3e-c6df-9e87-2e3c-b2a76ce61980@silicom-usa.com>
References: <201812051354.XWZtO56P%fengguang.wu@intel.com>
 <44210b3e-c6df-9e87-2e3c-b2a76ce61980@silicom-usa.com>
Message-ID: <b4d8cdb1-4842-4b1f-0506-f37838a2997c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/5/18 11:05 AM, Steve Douthit wrote:
> On 12/5/18 12:25 AM, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
>> head:   7e1ab79ec66131e03715c31928e09efd1c749cef
>> commit: 444b102251854611659c8569bef3e43049603f7c [14/17] ixgbe: register a mdiobus
>> config: i386-randconfig-s2-12051035 (attached as .config)
>> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
>> reproduce:
>>          git checkout 444b102251854611659c8569bef3e43049603f7c
>>          # save the attached .config to linux build tree
>>          make ARCH=i386
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ERROR: "__mdiobus_register" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
>>>> ERROR: "mdiobus_unregister" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
>>>> ERROR: "devm_mdiobus_alloc_size" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
>>>> ERROR: "devm_mdiobus_free" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
> 
> Jeff,
> 
> It looks like I should have had 'select PHYLIB' instead of 'select MII'
> in the Kconfig for this patch.

MDIO_DEVICE is more fine grained and probably what you want since you
only make use of the mdio_bus APIs and not the full PHYLIB API.

> 
> Would you prefer a v5 or to change that yourself?
> 
> -Steve
> 


-- 
Florian
