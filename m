From: Yong, Jonathan <jonathan.yong@intel.com>
Date: Tue, 16 Aug 2016 16:04:31 +0800
Subject: [Intel-wired-lan] [PATCH v6 1/3] PCI: Add Precision Time
	Measurement (PTM) support
In-Reply-To: <20160815185931.GD9790@localhost>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160613190534.12503.18923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <57AA984E.8040308@intel.com> <20160815185931.GD9790@localhost>
Message-ID: <57B2C90F.8010109@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 08/16/2016 02:59, Bjorn Helgaas wrote:
> 
> I guess I was hoping you could test these patches.  Do you have any
> way to do that?
> 

No real hardware with this feature yet, so testing is entirely on software.

> I rebased them and pushed them to pci/ptm.  If everything looks good,
> I'll merge them for v4.9.
> 
> Bjorn
> 

Looks like there is still this compile warning to fix:
http://patchwork.ozlabs.org/patch/634825/

