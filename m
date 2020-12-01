From: Martin K. Petersen <martin.petersen@oracle.com>
Date: Tue, 01 Dec 2020 00:52:27 -0500
Subject: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org> (Gustavo
 A. R. Silva's message of "Fri, 20 Nov 2020 12:21:39 -0600")
References: <cover.1605896059.git.gustavoars@kernel.org>
Message-ID: <yq1h7p6gjkk.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Gustavo,

> This series aims to fix almost all remaining fall-through warnings in
> order to enable -Wimplicit-fallthrough for Clang.

Applied 20-22,54,120-124 to 5.11/scsi-staging, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
