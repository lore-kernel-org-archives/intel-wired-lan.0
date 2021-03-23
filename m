From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 23 Mar 2021 18:45:30 +0000
Subject: [Intel-wired-lan] [PATCH next-queue v3 1/3] Revert "PCI: Make
 pci_enable_ptm() private"
In-Reply-To: <87zgytk92s.fsf@vcostago-mobl2.amr.corp.intel.com>
References: <20210322161822.1546454-1-vinicius.gomes@intel.com>
 <20210322161822.1546454-2-vinicius.gomes@intel.com>
 <20210323160122.GC2438080@infradead.org>
 <87zgytk92s.fsf@vcostago-mobl2.amr.corp.intel.com>
Message-ID: <20210323184530.GA2483289@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 23, 2021 at 11:40:11AM -0700, Vinicius Costa Gomes wrote:
> > Without an EXPORT_SYMBOL_GPL this is not going to be very useful for
> > your driver.
> 
> Unless I am missing something here, the commit that made
> 'pci_enable_ptm()' private didn't remove the 'EXPORT_SYMBOL' from the
> function definition in drivers/pci/pcie/ptm.c.

OOPS, indeed.  Looks like right now the function is nindeed exported,
but has no single user at all.
