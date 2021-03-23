From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 23 Mar 2021 15:49:18 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v3 1/3] Revert "PCI: Make
 pci_enable_ptm() private"
In-Reply-To: <20210323194046.GA598671@bjorn-Precision-5520>
References: <20210323194046.GA598671@bjorn-Precision-5520>
Message-ID: <874kh1jxjl.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Mon, Mar 22, 2021 at 09:18:20AM -0700, Vinicius Costa Gomes wrote:
>> Make pci_enable_ptm() accessible from the drivers.
>> 
>> Even if PTM still works on the platform I am using without calling
>> this function, it might be possible that it's not always the case.
>
> I don't understand the value of this paragraph.  The rest of it makes
> good sense (although I think we might want to add a wrapper as I
> mentioned elsewhere).
>

Sure. Will remove this paragraph, and add the helper as you mentioned.
Thanks.


Cheers,
-- 
Vinicius
