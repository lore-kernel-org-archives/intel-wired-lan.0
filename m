From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 27 Aug 2018 10:42:52 +0300
Subject: [Intel-wired-lan] [PATCH v6 03/11] igc: Add netdev
In-Reply-To: <54a5282f-df2e-378c-fdb6-124ef2bcd3b6@oracle.com>
References: <20180823070557.12312-1-sasha.neftin@intel.com>
 <54a5282f-df2e-378c-fdb6-124ef2bcd3b6@oracle.com>
Message-ID: <1090b26f-cd49-72c3-efed-c977a9b2fab6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/23/2018 19:37, Shannon Nelson wrote:
> On 8/23/2018 12:05 AM, Sasha Neftin wrote:
> 
> [...]
> 
>> +??? strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
> 
> [...]
> 
>> +??? strncpy(netdev->name, "eth%d", IFNAMSIZ);
> 
> I've mentioned this to you before: why are you setting the netdev->name 
> twice, and to different values?? Besides, the OS's udev rules will 
> likely change the name to something else.
> 
I believe I already answered in previous review (v3 or v4). Since I 
remove second settings of netdev->name: "strncpy(netdev->name, "eth%d", 
IFNAMSIZ)" I got error in probe: "probe of 0000:05:00.0 failed with 
error -22". I agree with you that we can do some optimization here - I 
will look later again in this code.
> 
>> +
>> +module_param(debug, int, 0);
>> +MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>> ? /* igc_main.c */
> 
> It would be nice to have this up above, next to the definition of int 
> debug.
> 
so, may be all code start from MODULE_AUTHOR... move to begin of the 
file. it is not urgent. I will look at other examples. what is benefit 
from this?
> sln
> 
Sasha
