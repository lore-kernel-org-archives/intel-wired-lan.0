From: Ronak Doshi <doshir@vmware.com>
Date: Mon, 1 Feb 2021 20:23:27 +0000
Subject: [Intel-wired-lan] Security issue with vmxnet3 and e100 for AMD
 SEV(-SNP) / Intel TDX
In-Reply-To: <AM7P194MB0900E443CEBD6EF2EE37325ED9AE0@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
References: <AM7P194MB0900E443CEBD6EF2EE37325ED9AE0@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
Message-ID: <733C4800-E161-4BDE-8706-12606E070F5D@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Vmxnet3 patch has been committed to mainline Linux
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/drivers/net/vmxnet3?id=de1da8bcf40564a2adada2d5d5426e05355f66e8


Thanks,
Ronak


From: "Radev, Martin" <martin.radev@aisec.fraunhofer.de>
Date: Friday, January 8, 2021 at 3:57 AM
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "intel-wired-lan at lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: Ronak Doshi <doshir@vmware.com>, "jesse.brandeburg at intel.com" <jesse.brandeburg@intel.com>, "anthony.l.nguyen at intel.com" <anthony.l.nguyen@intel.com>, "Morbitzer, Mathias" <mathias.morbitzer@aisec.fraunhofer.de>, Robert Buhren <robert.buhren@sect.tu-berlin.de>, "file at sect.tu-berlin.de" <file@sect.tu-berlin.de>, "Banse, Christian" <christian.banse@aisec.fraunhofer.de>, "brijesh.singh at amd.com" <brijesh.singh@amd.com>, "Thomas.Lendacky at amd.com" <Thomas.Lendacky@amd.com>, Pv-drivers <Pv-drivers@vmware.com>, "martin.b.radev at gmail.com" <martin.b.radev@gmail.com>
Subject: Security issue with vmxnet3 and e100 for AMD SEV(-SNP) / Intel TDX

Hello everybody,

tldr: Both drivers expose skb GVAs to untrusted devices which gives RIP
         control to a malicious e100 / vmxnet3 device implementation. This is
         an issue for AMD SEV (-SNP) [1] and likely Intel TDX [2].

Felicitas and Robert have started a project on fuzzing device drivers which
may have negative security impact on solutions like AMD SEV Secure
Nested Paging and Intel Trusted Domain Extensions. These solutions protect
a VM from a malicious Hypervisor in various way.

There are a couple of devices which carry security issues under the attacker
models of SEV-SNP / Intel TDX, but here we're only discussing VMXNET3 and
e100, because we have detailed PoCs for both.

Maintainers of both vmxnet3 and e100 were added in this email because the
discussion will likely be the same. The issues were already sent to AMD PSIRT,
and Tom Lendacky and Brijesh Singh have volunteered to be part of the email
communication with the maintainers. Both have been working on AMD SEV.

Please check the two attached files: vmxnet3_report.txt and e100_report.txt.
Both contain detailed information about what the issue is and how it can be
exploited by a malicious HV or attacker who has access to the QEMU process.

Fix:
In an earlier discussion with AMD, there was the idea of making a list of
allowed devices with SEV and forbidding everything else. This would avoid
issues with other drivers whose implementation has not been yet scrutinized
under the threat model of SEV-SNP and Intel Trusted Domain Extensions.

Let us know what you think.

Kind regards,
Martin

[1]: https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf<https://nam04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2FSEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf&data=04%7C01%7Cdoshir%40vmware.com%7C321954cba3ff43a816da08d8b3cc8c8e%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637457038522201270%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=BamituKoHDWFzZ%2FYVH5FQU93BblvsuNEcLWLBQIHaxQ%3D&reserved=0>
[2]: https://software.intel.com/content/www/us/en/develop/articles/intel-trust-domain-extensions.html<https://nam04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fwww%2Fus%2Fen%2Fdevelop%2Farticles%2Fintel-trust-domain-extensions.html&data=04%7C01%7Cdoshir%40vmware.com%7C321954cba3ff43a816da08d8b3cc8c8e%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637457038522211265%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=DKfk6PXESru%2Fq4U3Ct3HkmqAn%2BwCHLnzVKL7lCDMiDI%3D&reserved=0>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210201/5eb48d98/attachment-0001.html>
