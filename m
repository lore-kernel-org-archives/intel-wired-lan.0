From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 28 Sep 2020 15:32:23 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v1 1/3] Revert "PCI: Make
 pci_enable_ptm() private"
In-Reply-To: <20200928215432.GA2499272@bjorn-Precision-5520>
References: <20200928215432.GA2499272@bjorn-Precision-5520>
Message-ID: <87h7rhv8g8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Sep 25, 2020 at 04:28:32PM -0700, Vinicius Costa Gomes wrote:
>> Make pci_enable_ptm() accessible from the drivers.
>> 
>> Even if PTM still works on the platform I am using without calling
>> this this function, it might be possible that it's not always the
>> case.
>
> *Does* PTM work on your system without calling pci_enable_ptm()?  If
> so, I think that would mean the BIOS enabled PTM, and that seems
> slightly surprising.
>

At least it seems to work, yeah, the PTM related registers that I need
for cross timestamping still return valid results when I don't call
pci_enable_ptm().

Btw, I just noticed a typo in the commit message, will fix it for the
v2.

>> Exposing this to the driver enables the driver to use the
>> 'ptm_enabled' field of 'pci_dev' to check if PTM is enabled or not.
>> 
>> This reverts commit ac6c26da29c12fa511c877c273ed5c939dc9e96c.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> AFAICT we just never had any callers at all for pci_enable_ptm().  I
> probably shouldn't have merged it in the first place.
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks.

-- 
Vinicius
