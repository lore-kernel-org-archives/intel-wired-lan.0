From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 11 Nov 2015 14:09:54 -0800
Subject: [Intel-wired-lan] regression in ixgbe SFP detection patch
In-Reply-To: <20151111213458.GD3641@gandi.net>
References: <20151111173527.GA3641@gandi.net>
 <87618083B2453E4A8714035B62D67992504DF0AA@FMSMSX105.amr.corp.intel.com>
 <20151111213458.GD3641@gandi.net>
Message-ID: <5643BCB2.6070104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/11/2015 01:34 PM, William Dauchy wrote:
> On Nov11 20:33, Tantilov, Emil S wrote:
>> If the diff above is the patch you are referring to then you will break the
>> SFP+ detection in the case where the driver was loaded while there were no
>> SFP+ modules present in the cages.
> understood, I was surprised of the modification of behavior.

You might try testing against net-next to see if the problem still 
exists.  It looks like the code in question doesn't exist upstream as it 
was replaced in commit 45788d2af928 ("ixgbe: fix issue with sfp events 
with new X550 devices").

- Alex
