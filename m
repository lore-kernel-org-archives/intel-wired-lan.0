From: Radev, Martin <martin.radev@aisec.fraunhofer.de>
Date: Fri, 8 Jan 2021 11:57:10 +0000
Subject: [Intel-wired-lan] Security issue with vmxnet3 and e100 for AMD
 SEV(-SNP) / Intel TDX
Message-ID: <AM7P194MB0900E443CEBD6EF2EE37325ED9AE0@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

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

[1]: https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf
[2]: https://software.intel.com/content/www/us/en/develop/articles/intel-trust-domain-extensions.html

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210108/032074e9/attachment-0001.html>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: vmxnet3_report.txt
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210108/032074e9/attachment-0002.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: e100_report.txt
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210108/032074e9/attachment-0003.txt>
