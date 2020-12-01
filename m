From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Tue, 1 Dec 2020 02:20:47 -0600
Subject: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
In-Reply-To: <yq1h7p6gjkk.fsf@ca-mkp.ca.oracle.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <yq1h7p6gjkk.fsf@ca-mkp.ca.oracle.com>
Message-ID: <20201201082047.GA11832@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 01, 2020 at 12:52:27AM -0500, Martin K. Petersen wrote:
> 
> Gustavo,
> 
> > This series aims to fix almost all remaining fall-through warnings in
> > order to enable -Wimplicit-fallthrough for Clang.
> 
> Applied 20-22,54,120-124 to 5.11/scsi-staging, thanks.

Awesome! :)

Thanks, Martin.
--
Gustavo
