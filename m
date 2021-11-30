From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 30 Nov 2021 07:33:55 +0100
Subject: [Intel-wired-lan] [PATCH net] igb: fix deadlock caused by
 taking RTNL in RPM resume path
In-Reply-To: <20211129150920.4a400828@hermes.local>
References: <6bb28d2f-4884-7696-0582-c26c35534bae@gmail.com>
 <20211129150920.4a400828@hermes.local>
Message-ID: <5675a5ef-5aa0-3f05-1c44-a91ce90d5f38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 30.11.2021 00:09, Stephen Hemminger wrote:
> On Mon, 29 Nov 2021 22:14:06 +0100
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>> index dd208930f..8073cce73 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -9254,7 +9254,7 @@ static int __maybe_unused igb_suspend(struct device *dev)
>>  	return __igb_shutdown(to_pci_dev(dev), NULL, 0);
>>  }
>>  
>> -static int __maybe_unused igb_resume(struct device *dev)
>> +static int __maybe_unused __igb_resume(struct device *dev, bool rpm)
>>  {
>>  	struct pci_dev *pdev = to_pci_dev(dev);
>>  	struct net_device *netdev = pci_get_drvdata(pdev);
>> @@ -9297,17 +9297,24 @@ static int __maybe_unused igb_resume(struct device *dev)
>>  
>>  	wr32(E1000_WUS, ~0);
>>  
>> -	rtnl_lock();
>> +	if (!rpm)
>> +		rtnl_lock();
>>  	if (!err && netif_running(netdev))
>>  		err = __igb_open(netdev, true);
>>  
>>  	if (!err)
>>  		netif_device_attach(netdev);
>> -	rtnl_unlock();
>> +	if (!rpm)
>> +		rtnl_unlock();
>>  
>>  	return err;
>>  }
>>  
>> +static int __maybe_unused igb_resume(struct device *dev)
>> +{
>> +	return __igb_resume(dev, false);
>> +}
>> +
>>  static int __maybe_unused igb_runtime_idle(struct device *dev)
>>  {
>>  	struct net_device *netdev = dev_get_drvdata(dev);
>> @@ -9326,7 +9333,7 @@ static int __maybe_unused igb_runtime_suspend(struct device *dev)
>>  
>>  static int __maybe_unused igb_runtime_resume(struct device *dev)
>>  {
>> -	return igb_resume(dev);
>> +	return __igb_resume(dev, true);
>>  }
> 
> Rather than conditional locking which is one of the seven deadly sins of SMP,
> why not just have __igb_resume() be the locked version where lock is held by caller?
> 
In this case we'd have to duplicate quite some code from igb_resume().
Even more simple alternative would be to remove RTNL from igb_resume().
Then we'd remove RTNL from RPM and system resume path. Should be ok as well.
I just didn't want to change two paths at once.
