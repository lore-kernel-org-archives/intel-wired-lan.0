From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 30 Nov 2021 07:46:22 +0100
Subject: [Intel-wired-lan] [PATCH net] igb: fix deadlock caused by
 taking RTNL in RPM resume path
In-Reply-To: <20211129171712.500e37cb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <6bb28d2f-4884-7696-0582-c26c35534bae@gmail.com>
 <20211129171712.500e37cb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <6edc23a1-5907-3a41-7b46-8d53c5664a56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 30.11.2021 02:17, Jakub Kicinski wrote:
> On Mon, 29 Nov 2021 22:14:06 +0100 Heiner Kallweit wrote:
>> -	rtnl_lock();
>> +	if (!rpm)
>> +		rtnl_lock();
> 
> Is there an ASSERT_RTNL() hidden in any of the below? Can we add one?
> Unless we're 100% confident nobody will RPM resume without rtnl held..
> 

Not sure whether igb uses RPM the same way as r8169. There the device
is runtime-suspended (D3hot) w/o link. Once cable is plugged in the PHY
triggers a PME, and PCI core runtime-resumes the device (MAC).
In this case RTNL isn't held by the caller. Therefore I don't think
it's safe to assume that all callers hold RTNL.

>>  	if (!err && netif_running(netdev))
>>  		err = __igb_open(netdev, true);
>>  
>>  	if (!err)
>>  		netif_device_attach(netdev);
>> -	rtnl_unlock();
>> +	if (!rpm)
>> +		rtnl_unlock();

