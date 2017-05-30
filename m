From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 30 May 2017 08:41:38 -0700
Subject: [Intel-wired-lan] [i40e] regression on TCP stream and TCP
	maerts, kernel-4.12.0-0.rc2
In-Reply-To: <655ed9ab-853e-7497-9ea3-cc8d13f56043@redhat.com>
References: <655ed9ab-853e-7497-9ea3-cc8d13f56043@redhat.com>
Message-ID: <CAKgT0UcdJQWqr_zxxi36a6_3iMwBNow-YS723i7t6xsKvAqvCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 30, 2017 at 6:43 AM, Adam Okuliar <aokuliar@redhat.com> wrote:
> Hello,
>
> we found regression on intel card(XL710) with i40e driver. Regression is
> about ~45%
> on TCP_STREAM and TCP_MAERTS test for IPv4 and IPv6. Regression was first
> visible in kernel-4.12.0-0.rc1.
>
> More details about results you can see in uploaded images in bugzilla. [0]
>
>
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=195923
>
>
> Best regards, / S pozdravom,
>
> Adri?n Toma?ov
> Kernel Performance QE
> atomasov at redhat.com

I have added the i40e driver maintainer and the intel-wired-lan
mailing list so that we can make are developers aware of the issue.

Thanks.

- Alex
