From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 3 Apr 2019 02:09:59 +0000
Subject: [Intel-wired-lan] [PATCH] checkpatch.pl: allow commit
 descriptions	to include date
In-Reply-To: <20171005003358.3879-1-jacob.e.keller@intel.com>
References: <20171005003358.3879-1-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97023C5B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, October 4, 2017 5:34 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] checkpatch.pl: allow commit descriptions
> to include date
> 
> Since commit d311cd44545f ("checkpatch: add test for commit id
> formatting style in commit log") checkpatch has supported a check that
> git commit references are done in a standardized way.
> 
> Some communities (the Git mailing list, among others) advocate the
> addition of a date to the end of the description, converting
> 
>   d311cd44545f ("checkpatch: add test for commit id formatting style in
> commit log")
> 
> into
> 
>   d311cd44545f ("checkpatch: add test for commit id formatting style in
> commit log", 2014-08-06)
> 
> Extend checkpatch.pl to allow such a date, and add verification that the
> date matches the commit author date, if it exists.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  scripts/checkpatch.pl | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
