From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date: Mon, 11 Jan 2021 16:26:02 +0300
Subject: [Intel-wired-lan] Security issue with vmxnet3 and e100 for AMD
 SEV(-SNP) / Intel TDX
In-Reply-To: <AM7P194MB09004AD790C5C85EDCB42323D9AE0@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
References: <AM7P194MB0900E443CEBD6EF2EE37325ED9AE0@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
 <AM7P194MB09004AD790C5C85EDCB42323D9AE0@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
Message-ID: <20210111132602.bcd5hmtoqe4dcjwp@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 08, 2021 at 03:31:56PM +0000, Radev, Martin wrote:
> Just noticed that Intel TDX already does the device filtering. Check: https://github.com/intel/tdx/commit/6789eee52aab8985e49b362379fab73aa3eecde2
> 
> CC-ing Kirill and Kuppuswamy from Intel in case they want to be part of the discussion.
> ________________________________
> From: Radev, Martin
> Sent: Friday, January 8, 2021 12:57 PM
> To: netdev at vger.kernel.org <netdev@vger.kernel.org>; intel-wired-lan at lists.osuosl.org <intel-wired-lan@lists.osuosl.org>
> Cc: doshir at vmware.com <doshir@vmware.com>; jesse.brandeburg at intel.com <jesse.brandeburg@intel.com>; anthony.l.nguyen at intel.com <anthony.l.nguyen@intel.com>; Morbitzer, Mathias <mathias.morbitzer@aisec.fraunhofer.de>; Robert Buhren <robert.buhren@sect.tu-berlin.de>; file at sect.tu-berlin.de <file@sect.tu-berlin.de>; Banse, Christian <christian.banse@aisec.fraunhofer.de>; brijesh.singh at amd.com <brijesh.singh@amd.com>; Thomas.Lendacky at amd.com <Thomas.Lendacky@amd.com>; pv-drivers at vmware.com <pv-drivers@vmware.com>; martin.b.radev at gmail.com <martin.b.radev@gmail.com>
> Subject: Security issue with vmxnet3 and e100 for AMD SEV(-SNP) / Intel TDX
> 
> Hello everybody,
> 
> tldr: Both drivers expose skb GVAs to untrusted devices which gives RIP
>          control to a malicious e100 / vmxnet3 device implementation. This is
>          an issue for AMD SEV (-SNP) [1] and likely Intel TDX [2].
> 
> Felicitas and Robert have started a project on fuzzing device drivers which
> may have negative security impact on solutions like AMD SEV Secure
> Nested Paging and Intel Trusted Domain Extensions. These solutions protect
> a VM from a malicious Hypervisor in various way.
> 
> There are a couple of devices which carry security issues under the attacker
> models of SEV-SNP / Intel TDX, but here we're only discussing VMXNET3 and
> e100, because we have detailed PoCs for both.
> 
> Maintainers of both vmxnet3 and e100 were added in this email because the
> discussion will likely be the same. The issues were already sent to AMD PSIRT,
> and Tom Lendacky and Brijesh Singh have volunteered to be part of the email
> communication with the maintainers. Both have been working on AMD SEV.
> 
> Please check the two attached files: vmxnet3_report.txt and e100_report.txt.
> Both contain detailed information about what the issue is and how it can be
> exploited by a malicious HV or attacker who has access to the QEMU process.
> 
> Fix:
> In an earlier discussion with AMD, there was the idea of making a list of
> allowed devices with SEV and forbidding everything else. This would avoid
> issues with other drivers whose implementation has not been yet scrutinized
> under the threat model of SEV-SNP and Intel Trusted Domain Extensions.

+Andi.

Right. Our TDX guest enabling has white list of devices that allowed to be
used. For now it's only VirtIO, but I believe it also requires hardening.
We need to validate any VMM input.

It might be beneficial to have coordination between Intel and AMD on what
devices (and device drivers) considered to be safe for trusted computing.
I think we can share burden of code audit and fuzzing.

-- 
 Kirill A. Shutemov
