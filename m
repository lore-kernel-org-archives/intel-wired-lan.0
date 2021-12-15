From: Vadim Fedorenko <vfedorenko@novek.ru>
Date: Wed, 15 Dec 2021 22:27:46 +0000
Subject: [Intel-wired-lan] [PATCH v5 net-next 0/4] Add ethtool interface
 for RClocks
In-Reply-To: <DM6PR11MB4657CE134223B65B5F2EF5F29B769@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20211210134550.1195182-1-maciej.machnikowski@intel.com>
 <20211210081654.233a41b6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <MW5PR11MB58126A8F6466A8EAD1293D5EEA749@MW5PR11MB5812.namprd11.prod.outlook.com>
 <DM6PR11MB4657CE134223B65B5F2EF5F29B769@DM6PR11MB4657.namprd11.prod.outlook.com>
Message-ID: <4d4f5c27-90a3-c411-ea2f-e6f44ec74148@novek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 15.12.2021 12:14, Kubalewski, Arkadiusz wrote:
>> -----Original Message-----
>> From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
>> Sent: poniedzia?ek, 13 grudnia 2021 09:54
>> To: Jakub Kicinski <kuba@kernel.org>
>> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; richardcochran at gmail.com; Byagowi, Ahmad <abyagowi@fb.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem at davemloft.net; linux-kselftest at vger.kernel.org; idosch at idosch.org; mkubecek at suse.cz; saeed at kernel.org; michael.chan at broadcom.com; petrm at nvidia.com; Vadim Fedorenko <vfedorenko@novek.ru>
>> Subject: RE: [PATCH v5 net-next 0/4] Add ethtool interface for RClocks
>>
>>> -----Original Message-----
>>> From: Jakub Kicinski <kuba@kernel.org>
>>> Sent: Friday, December 10, 2021 5:17 PM
>>> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
>>> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
>>> Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>;
>>> richardcochran at gmail.com; Byagowi, Ahmad <abyagowi@fb.com>; Nguyen,
>>> Anthony L <anthony.l.nguyen@intel.com>; davem at davemloft.net; linux-
>>> kselftest at vger.kernel.org; idosch at idosch.org; mkubecek at suse.cz;
>>> saeed at kernel.org; michael.chan at broadcom.com; petrm at nvidia.com; Vadim
>>> Fedorenko <vfedorenko@novek.ru>
>>> Subject: Re: [PATCH v5 net-next 0/4] Add ethtool interface for RClocks
>>>
>>> On Fri, 10 Dec 2021 14:45:46 +0100 Maciej Machnikowski wrote:
>>>> Synchronous Ethernet networks use a physical layer clock to
>>>> syntonize the frequency across different network elements.
>>>>
>>>> Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
>>>> Equipment Clock (EEC) and have the ability to synchronize to
>>>> reference frequency sources.
>>>>
>>>> This patch series is a prerequisite for EEC object and adds ability
>>>> to enable recovered clocks in the physical layer of the netdev object.
>>>> Recovered clocks can be used as one of the reference signal by the EEC.
>>>>
>>>> Further work is required to add the DPLL subsystem, link it to the
>>>> netdev object and create API to read the EEC DPLL state.
>>>
>>> You missed CCing Vadim. I guess Ccing the right people may be right up
>>> there with naming things as the hardest things in SW development..
>>>
>>> Anyway, Vadim - do you have an ETA on the first chunk of the PLL work?
>>
>> Sounds about right :) thanks for adding Vadim!
>>
> 
> Good day Vadim,
> 
> Can we help on the new PLL interfaces?
> I can start some works related to that, although would need a guidance
> from the expert.
> Where to place it?
> What in-kernel interfaces to use?
> Any other high level tips that could be useful?
> Or if you already started some work, could you please share some
> information?
> 
Hi!

I'm going to publish RFC till the end of the week and we will be able to
continue discussion via this mailing list. I think that netlink is a good
option for in-kernel interface and is easy to implement.

