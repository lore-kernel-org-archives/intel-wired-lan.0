From: Dave Hansen <dave@sr71.net>
Date: Mon, 28 Sep 2015 08:57:18 -0700
Subject: [Intel-wired-lan] [PATCH] e1000: fix
	e1000e_disable_aspm_locked() warning
In-Reply-To: <20150831212641.FA5D579A@viggo.jf.intel.com>
References: <20150831212641.FA5D579A@viggo.jf.intel.com>
Message-ID: <5609635E.6010907@sr71.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 08/31/2015 02:26 PM, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I have a .config with CONFIG_PM disabled.  I get the following whenever
> compiling the e1000 driver:
> 
> ...net/ethernet/intel/e1000e/netdev.c:6450:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
>  static void e1000e_disable_aspm_locked(struct pci_dev *pdev, u16 state)
> 
> Looks like we just need to move e1000e_disable_aspm_locked() to
> be underneath the CONFIG_PM #ifdef.

This patch:

	[2758f9edb]: e1000e: Fix incorrect ASPM locking

established a new caller for e1000e_disable_aspm_locked() which makes my
patch useless and wrong (it breaks the compile).

I believe we should just revert my patch.
