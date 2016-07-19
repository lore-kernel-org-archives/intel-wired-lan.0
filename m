From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 19 Jul 2016 16:19:26 -0500
Subject: [Intel-wired-lan] [PATCH v6 0/3] PCI: Precision Time
	Measurement support
In-Reply-To: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160719211926.GB17840@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jun 13, 2016 at 02:05:26PM -0500, Bjorn Helgaas wrote:
> This is a slightly different proposal for the PTM support Jonathan
> proposed here:
> 
>   http://lkml.kernel.org/r/1462956446-27361-2-git-send-email-jonathan.yong at intel.com
> 
> I split this into three pieces mostly for ease in reviewing.  They
> could all be squashed:
> 
>   - Enable PTM in root ports and switches automatically at boot
>   - Enable PTM in endpoints when requested by driver
>   - Add clock granularity information
> 
> I have some open questions about how PTM works on Root Complex
> Integrated Endpoints and whether we should enable it automatically
> even without a driver request.  And I probably left out some details
> of the clock granularity computation, so treat this as more of an RFC
> than anything.
> 
> Bjorn
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: Add pci_enable_ptm() for drivers to enable PTM on endpoints
>       PCI: Add PTM clock granularity information
> 
> Jonathan Yong (1):
>       PCI: Add Precision Time Measurement (PTM) support

Jonathan, any comments?
