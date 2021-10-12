From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 12 Oct 2021 12:28:25 -0700
Subject: [Intel-wired-lan] i40e pppoe rss
In-Reply-To: <20211011222800.GA17234@kvack.org>
References: <20211011222800.GA17234@kvack.org>
Message-ID: <55127ee0-e85c-9dba-4086-31516a843d27@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/11/2021 3:28 PM, Benjamin LaHaise wrote:
> I have been trying to get RSS working for incoming PPPoE packets with the
> Linux i40e driver.  After loading the DDP .pkgo file for PPPoE using
> "ethtool -f enp43s0f0 ppp-oe-ol2tpv2.pkgo 100", packets still come in on a
> single queue.  Changing destination IP addresses or port numbers in UDP
> packets does not result in any change in the ingress queue.  Are the
> ethtool commands required to enable RSS with PPPoE documented anywhere?
> The only documentation seems to rely on test-pmd with DPDK, but I am using
> the native Linux drivers and XDP.

Hi Ben, this was a known issue on an older package version, and since 
you asked, we realized that the version on intel.com hasn't been updated 
in a long time, and so doesn't have the fix.

We are working to correct the internal issues that lead to this stale 
package being left there and not updated, and are grateful you pointed 
us to the issue!

Please keep an eye out for the intel.com download page to be updated 
with the latest PPPoE package. Once you have that, RSS should start 
working correctly after loading the newer package.

Thanks for your patience, I don't have a direct ETA on this, but I did 
start the ball rolling internally.

-Jesse
