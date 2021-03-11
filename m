From: Simon Horman <simon.horman@netronome.com>
Date: Thu, 11 Mar 2021 12:51:15 +0100
Subject: [Intel-wired-lan] [RFC PATCH 03/10] nfp: Replace nfp_pr_et with
 ethtool_gsprintf
In-Reply-To: <161542653266.13546.11914667071718045956.stgit@localhost.localdomain>
References: <161542634192.13546.4185974647834631704.stgit@localhost.localdomain>
 <161542653266.13546.11914667071718045956.stgit@localhost.localdomain>
Message-ID: <20210311115115.GA12530@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 10, 2021 at 05:35:32PM -0800, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The nfp_pr_et function is nearly identical to ethtool_gsprintf except for
> the fact that it passes the pointer by value and as a return whereas
> ethtool_gsprintf passes it as a pointer.
> 
> Since they are so close just update nfp to make use of ethtool_gsprintf
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>
