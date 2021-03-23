From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 23 Mar 2021 11:40:11 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v3 1/3] Revert "PCI: Make
 pci_enable_ptm() private"
In-Reply-To: <20210323160122.GC2438080@infradead.org>
References: <20210322161822.1546454-1-vinicius.gomes@intel.com>
 <20210322161822.1546454-2-vinicius.gomes@intel.com>
 <20210323160122.GC2438080@infradead.org>
Message-ID: <87zgytk92s.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, Mar 22, 2021 at 09:18:20AM -0700, Vinicius Costa Gomes wrote:
>> Make pci_enable_ptm() accessible from the drivers.
>> 
>> Even if PTM still works on the platform I am using without calling
>> this function, it might be possible that it's not always the case.
>> 
>> Exposing this to the driver enables the driver to use the
>> 'ptm_enabled' field of 'pci_dev' to check if PTM is enabled or not.
>> 
>> This reverts commit ac6c26da29c12fa511c877c273ed5c939dc9e96c.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Without an EXPORT_SYMBOL_GPL this is not going to be very useful for
> your driver.

Unless I am missing something here, the commit that made
'pci_enable_ptm()' private didn't remove the 'EXPORT_SYMBOL' from the
function definition in drivers/pci/pcie/ptm.c.


Cheers,
-- 
Vinicius
