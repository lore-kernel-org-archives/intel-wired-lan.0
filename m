From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Fri, 01 Oct 2021 10:23:35 +0200
Subject: [Intel-wired-lan] Oops in during sriov_enable with ixgbe driver
In-Reply-To: <CAJZ5v0hsQvHp2PqFjxvyx4tPCnNC7BCWyfPj-eADFa1w68BCMQ@mail.gmail.com>
References: <8e4bbd5c59de31db71f718556654c0aa077df03d.camel@linux.ibm.com>
 <5ea40608-388e-1137-9b86-85aad1cad6f6@intel.com>
 <b9e461a5-75de-6f45-1709-d9573492f7ac@intel.com>
 <CAJZ5v0gpxRDt0V3Eh1_edZAudxyL3-ik4MhT7TzijTYeOd=_Vg@mail.gmail.com>
 <CAJZ5v0hsQvHp2PqFjxvyx4tPCnNC7BCWyfPj-eADFa1w68BCMQ@mail.gmail.com>
Message-ID: <924c2d6ef51a83cce5c9bcf4004bbf1506c5a768.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-09-30 at 20:37 +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 30, 2021 at 8:20 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Sep 30, 2021 at 7:38 PM Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com> wrote:
> > > On 9/30/2021 7:31 PM, Jesse Brandeburg wrote:
> > > > On 9/28/2021 4:56 AM, Niklas Schnelle wrote:
> > > > > Hi Jesse, Hi Tony,
> > > > > 
> > > > > Since v5.15-rc1 I've been having problems with enabling SR-IOV VFs on
> > > > > my private workstation with an Intel 82599 NIC with the ixgbe driver. I
> > > > > haven't had time to bisect or look closer but since it still happens on
> > > > > v5.15-rc3 I wanted to at least check if you're aware of the problem as
> > > > > I couldn't find anything on the web.
> > > > We haven't heard anything of this problem.
> > > > 
> > > > 
> > > > > I get below Oops when trying "echo 2 > /sys/bus/pci/.../sriov_numvfs"
> > > > > and suspect that the earlier ACPI messages could have something to do
> > > > > with that, absolutely not an ACPI expert though. If there is a need I
> > > > > could do a bisect.
> > > > Hi Niklas, thanks for the report, I added the Intel Driver's list for
> > > > more exposure.
> > > > 
> > > > I asked the developers working on that driver to take a look and they
> > > > tried to reproduce, and were unable to do so. This might be related to
> > > > your platform, which strongly suggests that the ACPI stuff may be related.
> > > > 
> > > > We have tried to reproduce but everything works fine no call trace in
> > > > scenario with creating VF.
> > > > 
> > > > This is good in that it doesn't seem to be a general failure, you may
> > > > want to file a kernel bugzilla (bugzilla.kernel.org) to track the issue,
> > > > and I hope that @Rafael might have some insight.
> > > > 
> > > > This issue may be related to changes in acpi_pci_find_companion,
> > > > but as I say, we are not able to reproduce this.
> > > > 
> > > > commit 59dc33252ee777e02332774fbdf3381b1d5d5f5d
> > > > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Date:   Tue Aug 24 16:43:55 2021 +0200
> > > >      PCI: VMD: ACPI: Make ACPI companion lookup work for VMD bus
> > > 
> > > This change doesn't affect any devices beyond the ones on the VMD bus.
> > 
> > The only failing case I can see is when the device is on the VMD bus
> > and its bus pointer is NULL, so the dereference in
> > vmd_acpi_find_companion() crashes.
> > 
> > Can anything like that happen?
> 
> Not really, because pci_iov_add_virtfn() sets virtfn->bus.
> 
> However, it doesn\t set virtfn->dev.parent AFAICS, so when that gets
> dereferenced by ACPI_COMPANIO(dev->parent) in
> acpi_pci_find_companion(), the crash occurs.
> 
> We need a !dev->parent check in acpi_pci_find_companion() I suppose:
> 
> Does the following change help?
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1243,6 +1243,9 @@ static struct acpi_device *acpi_pci_find
>      bool check_children;
>      u64 addr;
> 
> +    if (!dev->parent)
> +        return NULL;
> +
>      down_read(&pci_acpi_companion_lookup_sem);
> 
>      adev = pci_acpi_find_companion_hook ?


Yes the above change fixes the problem for me. SR-IOV enables
successfully and the VFs are fully usable. Thanks!

Just out of curiosity and because I use this system to test common code
PCI changed. Do you have an idea what makes my system special here? 

The call to pci_set_acpi_fwnode() in pci_setup_device() is
unconditional and should do the same on any ACPI enabled system.
Also nothing in your explanation sounds specific to my system.

