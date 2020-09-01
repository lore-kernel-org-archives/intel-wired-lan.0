From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Aug 2020 21:35:19 -0400
Subject: [Intel-wired-lan] VRRP not working on i40e X722 S2600WFT
In-Reply-To: <20200831103512.00001fab@intel.com>
References: <20200827183039.hrfnb63cxq3pmv4z@csclub.uwaterloo.ca>
 <20200828155616.3sd2ivrml2gpcvod@csclub.uwaterloo.ca>
 <20200831103512.00001fab@intel.com>
Message-ID: <20200901013519.rfmavd4763gdzw4r@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 31, 2020 at 10:35:12AM -0700, Jesse Brandeburg wrote:
> Thanks for the report Lennart, I understand your frustration, as this
> should probably work without user configuration.
> 
> However, please give this command a try:
> ethtool --set-priv-flags ethX disable-source-pruning on

Hmm, our 4.9 kernel is just a touch too old to support that.  And yes
that really should not require a flag to be set, given the card has no
reason to ever do that pruning.  There is no justification you could
have for doing it in the first place.

-- 
Len Sorensen
