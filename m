From: Benjamin LaHaise <bcrl@kvack.org>
Date: Thu, 14 Oct 2021 16:25:12 -0400
Subject: [Intel-wired-lan] i40e pppoe rss
In-Reply-To: <6bb0f7d2-1d25-0d0a-7141-ebd277082994@intel.com>
References: <20211011222800.GA17234@kvack.org>
 <55127ee0-e85c-9dba-4086-31516a843d27@intel.com>
 <6bb0f7d2-1d25-0d0a-7141-ebd277082994@intel.com>
Message-ID: <20211014202512.GD30927@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jesse,

On Thu, Oct 14, 2021 at 12:52:17PM -0700, Jesse Brandeburg wrote:
> On 10/12/2021 12:28 PM, Jesse Brandeburg wrote:
> >Please keep an eye out for the intel.com download page to be updated 
> >with the latest PPPoE package. Once you have that, RSS should start 
> >working correctly after loading the newer package.
> >
> >Thanks for your patience, I don't have a direct ETA on this, but I did 
> >start the ball rolling internally.
> 
> The latest package has been uploaded, feedback is appreciated.
> https://downloadcenter.intel.com/download/28040

It looks like this works for UDP, which is good.  All ICMP packets
seem to end up on the same rx queue regardless of source or destination ip
address which is not ideal.  I'll run a few more tests, but this is
definitely better than it was.  Thanks!

		-ben
-- 
"Thought is the essence of where you are now."
