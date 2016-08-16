From: Yong, Jonathan <jonathan.yong@intel.com>
Date: Tue, 16 Aug 2016 09:27:05 +0800
Subject: [Intel-wired-lan] [PATCH v6 0/3] PCI: Precision Time
	Measurement support
In-Reply-To: <20160815185111.GC9790@localhost>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160719211926.GB17840@localhost> <578EBC81.3090601@intel.com>
 <20160815185111.GC9790@localhost>
Message-ID: <57B26BE9.3060902@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 08/16/2016 02:51, Bjorn Helgaas wrote:
>>
>> This line:
>> ctrl = PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT;
>>
>> should also set the responder capable bit (7.32.2):
>> 	If PTM Root Capable is Set, this bit must be Set to 1b.
> 
> The PTM Responder Capable bit (bit 1 in Table 7-145) is a HwInit bit
> in the PTM Capability register, so it's read-only from the kernel's
> perspective.
> 
> The line you mention ("ctrl = PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT")
> is turning on bits in the PTM Control register, not the Capability
> register.
> 

My bad, there is no "responder enable" bit control, patch looks good.

