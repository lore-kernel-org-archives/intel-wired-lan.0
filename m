From: Zhi Wang <zhi.wang.linux@gmail.com>
Date: Mon, 2 Oct 2017 20:05:41 +0300
Subject: [Intel-wired-lan] [Intel-gfx] [PATCH 00/18] use ARRAY_SIZE macro
In-Reply-To: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Message-ID: <CAN=xO46tCDaaHRdaDmXgaJ+ub3nfEWvZLnMeih+3C4zcxoU-0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks for the patch! :)

2017-10-01 22:30 GMT+03:00 J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>:

> Hi everyone,
> Using ARRAY_SIZE improves the code readability. I used coccinelle (I
> made a change to the array_size.cocci file [1]) to find several places
> where ARRAY_SIZE could be used instead of other macros or sizeof
> division.
>
> I tried to divide the changes into a patch per subsystem (excepted for
> staging). If one of the patch should be split into several patches, let
> me know.
>
> In order to reduce the size of the To: and Cc: lines, each patch of the
> series is sent only to the maintainers and lists concerned by the patch.
> This cover letter is sent to every list concerned by this series.
>
> This series is based on linux-next next-20170929. Each patch has been
> tested by building the relevant files with W=1.
>
> This series contains the following patches:
> [PATCH 01/18] sound: use ARRAY_SIZE
> [PATCH 02/18] tracing/filter: use ARRAY_SIZE
> [PATCH 03/18] media: use ARRAY_SIZE
> [PATCH 04/18] IB/mlx5: Use ARRAY_SIZE
> [PATCH 05/18] net: use ARRAY_SIZE
> [PATCH 06/18] drm: use ARRAY_SIZE
> [PATCH 07/18] scsi: bfa: use ARRAY_SIZE
> [PATCH 08/18] ecryptfs: use ARRAY_SIZE
> [PATCH 09/18] nfsd: use ARRAY_SIZE
> [PATCH 10/18] orangefs: use ARRAY_SIZE
> [PATCH 11/18] dm space map metadata: use ARRAY_SIZE
> [PATCH 12/18] x86: use ARRAY_SIZE
> [PATCH 13/18] tpm: use ARRAY_SIZE
> [PATCH 14/18] ipmi: use ARRAY_SIZE
> [PATCH 15/18] acpi: use ARRAY_SIZE
> [PATCH 16/18] media: staging: atomisp: use ARRAY_SIZE
> [PATCH 17/18] staging: rtl8723bs: use ARRAY_SIZE
> [PATCH 18/18] staging: rtlwifi: use ARRAY_SIZE
>
>
> [1]: https://lkml.org/lkml/2017/9/13/689
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171002/e783c6fe/attachment.html>
