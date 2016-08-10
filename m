From: Yong, Jonathan <jonathan.yong@intel.com>
Date: Wed, 10 Aug 2016 10:58:22 +0800
Subject: [Intel-wired-lan] [PATCH v6 1/3] PCI: Add Precision Time
	Measurement (PTM) support
In-Reply-To: <20160613190534.12503.18923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160613190534.12503.18923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <57AA984E.8040308@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/14/2016 03:05, Bjorn Helgaas wrote:
> From: Jonathan Yong <jonathan.yong@intel.com>
> 
> Add Precision Time Measurement (PTM) support (see PCIe r3.1, sec 6.22).
> 
> Enable PTM on PTM Root devices and switch ports.  This does not enable PTM
> on endpoints.
> 
> There currently are no PTM-capable devices on the market, but it is
> expected to be supported by the Intel Apollo Lake platform.
> 
> [bhelgaas: complete rework]
> Signed-off-by: Jonathan Yong <jonathan.yong@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Hi,

Any updates on the PTM changes?


