require "rails_helper"

RSpec.describe ChatRoomChannel, type: :channel do
  before do
    stub_connection chat_room_id: 1
  end
  
  it "subscribes without streams when no room id" do
    subscribe

    expect(subscription).to be_confirmed
    expect(subscription).not_to have_streams
  end

  it "rejects when room id is invalid" do
    subscribe(room_id: -1)

    expect(subscription).to be_rejected
  end

  it "subscribes to a stream when room id is provided" do
    subscribe(room_id: 1)

    expect(subscription).to be_confirmed

    # check particular stream by name
    expect(subscription).to have_stream_from("room")

    # or directly by model if you create streams with `stream_for`
    expect(subscription).to have_stream_for(Room.find(1))
  end
end
