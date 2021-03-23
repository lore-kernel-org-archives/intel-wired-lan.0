From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 23 Mar 2021 12:40:49 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v3 2/3] igc: Enable PCIe PTM
In-Reply-To: <20210323192920.GA597326@bjorn-Precision-5520>
References: <20210323192920.GA597326@bjorn-Precision-5520>
Message-ID: <87mtutk69q.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Mon, Mar 22, 2021 at 09:18:21AM -0700, Vinicius Costa Gomes wrote:
>> In practice, enabling PTM also sets the enabled_ptm flag in the PCI
>> device, the flag will be used for detecting if PTM is enabled before
>> adding support for the SYSOFFSET_PRECISE ioctl() (which is added by
>> implementing the getcrosststamp() PTP function).
>
> I think you're referring to the "pci_dev.ptm_enabled" flag.  I'm not
> sure what the connection to this patch is.  The SYSOFFSET_PRECISE
> stuff also seems to belong with some other patch.

Yeah, I will improve the commit message to make it clear that this patch
is a preparation patch for the one that will add support for
PTP_SYS_OFFSET_PRECISE/getcrosststamp() and what's the relation with
PCIe PTM.

>
> This patch merely enables PTM if it's supported (might be worth
> expanding Precision Time Measurement for context).

Yes. Will expand the definition in the commit message.


Cheers,
-- 
Vinicius
