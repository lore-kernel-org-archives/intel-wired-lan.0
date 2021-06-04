From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 04 Jun 2021 16:27:04 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v4 1/4] Revert "PCI: Make
 pci_enable_ptm() private"
In-Reply-To: <20210604222542.GA2246166@bjorn-Precision-5520>
References: <20210604222542.GA2246166@bjorn-Precision-5520>
Message-ID: <87bl8lxlbr.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Jun 04, 2021 at 03:09:30PM -0700, Vinicius Costa Gomes wrote:
>> Make pci_enable_ptm() accessible from the drivers.
>> 
>> Even if PTM still works on the platform I am using without calling
>> this function, it might be possible that it's not always the case.
>
> Not really relevant to this commit, strictly speaking.
>

Will remove then.

>> Exposing this to the driver enables the driver to use the
>> 'ptm_enabled' field of 'pci_dev' to check if PTM is enabled or not.
>> 
>> This reverts commit ac6c26da29c12fa511c877c273ed5c939dc9e96c.
>
> Ideally I would cite this as ac6c26da29c1 ("PCI: Make pci_enable_ptm()
> private") so there's a little more context.
>

Yeah, that looks better.

Will follow the suggestions you made in the next patch as well and send
another version, thanks.


Cheers,
-- 
Vinicius
