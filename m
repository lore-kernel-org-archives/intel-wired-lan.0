From: Matthew Finlay <Matt@Mellanox.com>
Date: Fri, 29 Apr 2016 01:18:23 +0000
Subject: [Intel-wired-lan] [RFC PATCH 2/5] mlx5: Add support for UDP
 tunnel segmentation with outer checksum offload
In-Reply-To: <CAKgT0UfsB+CbsCjerxDYkWgdGN01vmf4=VJRLEarFO4_nf-pow@mail.gmail.com>
References: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
 <20160419190603.11723.31623.stgit@ahduyck-xeon-server>
 <CALzJLG-8enmxxvjbVbcygVgM0VhX7Eo=6B=2pZF5jQzN9L9YEg@mail.gmail.com>
 <CAKgT0Uc5poLcTzkeA_8fi2jQeF08zbtj3+obTG1q0ha+ESZRCQ@mail.gmail.com>
 <800B6BE4-251F-4AA5-92FC-3A9393E7981E@mellanox.com>
 <CAKgT0UfsB+CbsCjerxDYkWgdGN01vmf4=VJRLEarFO4_nf-pow@mail.gmail.com>
Message-ID: <49111DBA-CDD6-4D19-9D2D-D6E29675A28F@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>






>>
>> The mlx5 hardware requires the outer UDP checksum is not set when offloading encapsulated packets.
>
>The Intel documentation said the same thing.  That was due to the fact
>that the hardware didn't computer the outer UDP header checksum.  I
>suspect the Mellanox hardware has the same issue.  Also I have tested
>on a ConnectX-4 board with the latest firmware and what I am seeing is
>that with my patches applied the outer checksum is being correctly
>applied for segmentation offloads.
>
>My thought is that that the hardware appears to ignore the UDP
>checksum so if it is non-zero you cannot guarantee the checksum would
>be correct on the last frame if it is a different size than the rest
>of the segments.  In the case of these patches that issue has been
>resolved as I have precomputed the UDP checksum for the outer UDP
>header and all of the segments will be the same length so there should
>be no variation in the UDP checksum of the outer header.  Unless you
>can tell my exactly the reason why we cannot provide the outer UDP
>checksum I would assume that the reason is due to the fact that the
>hardware doesn't compute it so you cannot handle a fragment on the end
>which is resolved already via GSO_PARTIAL.

I will check internally and verify there are no unforeseen issues with setting the outer UDP checksum in this scenario.

>
>- Alex
